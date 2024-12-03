//! In the context of this project, a polyfill is an implementation of some
//! functionality that is _not_ supported by our target CPU in terms of
//! functionality that _is_ supported by our target.
//!
//! By way of example, consider that our CPU does not support floating point
//! arithmetic, so to compile LLVM code that uses such a thing we need to
//! implement it and call _our_ functions where it needs to perform these
//! operations.
//!
//! Our polyfill mechanism aims to be generic, such that we can implement and
//! improve our polyfills without requiring invasive changes to the code-base.
//! In order to do this, we have created a _library_ of polyfills that the
//! compilation process (see [`crate::Compiler`]) can select from dynamically.
//!
//! # Polyfills and Optimization
//!
//! We are implementing our polyfills in Cairo-the-language, thereby enabling us
//! to have them in the same form as our compiled LLVM IR: `FlatLowered`. This
//! means that we can combine the polyfills and source into a compilation unit
//! seamlessly.
//!
//! While implementing these in Cairo means that they are amenable to rapid
//! iteration and experimentation, the polyfill is not the _end goal_ of this
//! process.
//!
//! 1. **Polyfills:** Implemented in Cairo, these implement functionality that
//!    our CPU is missing using functionality that it is not. They are slow in
//!    that they take more steps than the other options to perform an operation,
//!    but are much easier to experiment with and iterate on.
//! 2. **Builtins:** Builtins are units of functionality written in Rust that
//!    act as coprocessors using a DMA-like mechanism to receive operands and
//!    provide results back to the executing code. These are much faster to
//!    execute, taking few steps at most, but are more invasive to experiment
//!    with and change. They may also require more memory than an equivalent
//!    polyfill, which would increase the verification time.
//! 3. **AIR Instructions:** AIR instructions are the fastest option here, but
//!    adding a new instruction has the downside of increasing the width of the
//!    trace table. Any increase in table width increases the size of the table
//!    and also the time to prove the execution.
//!
//! Starting with the polyfills, however, allows us to experiment and iterate
//! rapidly to arrive at a design that we are happy with. This would be far more
//! complex for a builtin, and more complex still for an AIR instruction.
//!
//! Perhaps more importantly, the polyfills allow us to examine and profile to
//! find which operations will be most effective to "upgrade". Rather than a
//! scattershot approach based on hunches, the polyfills allow us to base these
//! decisions on real-world data.
//!
//! To that end, there are certainly polyfills that will still exist. It is very
//! unlikely that every single operation is beneficial to implement as a builtin
//! or AIR instruction.

// NOTE: When adding new polyfills, you will need to alter the expected number
// of polyfills in the tests.

use std::{
    collections::HashMap,
    fmt::{Display, Formatter},
};

use hieratika_errors::compile::llvm::{Error, Result};
use itertools::Itertools;

use crate::llvm::typesystem::LLVMType;

/// Generates a binary operation with the provided `name` and with a type
/// equivalent to  `a -> a -> a`.
macro_rules! binop {
    ($name:ident, $tys:ident) => {
        fn $name(&mut self) {
            for typ in Self::$tys() {
                self.mk(stringify!($name), &[typ.clone(), typ.clone()], typ.clone());
            }
        }
    };
}

/// Generates a unary intrinsic with the provided `name` and with a type
/// equivalent to `a -> a`.
macro_rules! unary_intrinsic {
    ($name:ident, $tys:ident) => {
        fn $name(&mut self) {
            let base_name = format!("llvm.{}", stringify!($name));
            for typ in Self::$tys() {
                let name = format!("{base_name}.{typ}");
                let arg_types = &[typ.clone()];
                let return_type = typ.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(&base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    };
}

/// Generates a binary intrinsic with the provided `name` and with a type
/// equivalent to either `a -> a -> a` in the first case, or `a -> a -> b` in
/// the second.
macro_rules! binary_intrinsic {
    ($name:ident, $tys:ident) => {
        fn $name(&mut self) {
            let base_name = format!("llvm.{}", stringify!($name));
            for typ in Self::$tys() {
                let name = format!("{base_name}.{typ}");
                let arg_types = &[typ.clone(), typ.clone()];
                let return_type = typ.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(&base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    };
    ($name:ident, $tys:ident, $fixed_ret:expr) => {
        fn $name(&mut self) {
            let base_name = format!("llvm.{}", stringify!($name));
            for typ in Self::$tys() {
                let name = format!("{base_name}.{}.{typ}", $fixed_ret.clone());
                let arg_types = &[typ.clone(), typ.clone()];
                let return_type = $fixed_ret;
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(&base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    };
}

/// A mapping between a specifically-typed opcode instance and the corresponding
/// polyfill name.
pub type PolyMapping = HashMap<LLVMOperation, String>;

/// An opcode instance with its types fully specified, used to map specific
/// instances of opcodes or intrinsics to the specific output polyfill name.
#[derive(Clone, Debug, Eq, Hash, PartialEq)]
pub struct LLVMOperation {
    /// The name of the operation.
    pub opcode_name: String,

    /// The types of the operands to the operation.
    pub operand_types: Vec<LLVMType>,

    /// The return type of the operation.
    pub return_type: LLVMType,
}

impl LLVMOperation {
    /// Creates an opcode representing the operation with the given `name`,
    /// parameter types `ops`, and return-type `ret`.
    #[must_use]
    pub fn of(name: &str, ops: &[LLVMType], ret: LLVMType) -> Self {
        Self {
            opcode_name:   name.to_string(),
            operand_types: ops.to_vec(),
            return_type:   ret,
        }
    }
}

/// To make it easier to visualize these operations without compromising the
/// structural debug output.
impl Display for LLVMOperation {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let args_str = self
            .operand_types
            .iter()
            .map(std::string::ToString::to_string)
            .join(" -> ");
        let ret_str = self.return_type.to_string();
        write!(f, "{} : {} -> {}", self.opcode_name, args_str, ret_str)
    }
}

/// A mapping from the builtin names for LLVM to the internal names for the
/// corresponding polyfills.
///
/// This exists in order to enable external linkage of symbols not part of the
/// current translation unit.
///
/// # LLVM Opcodes
///
/// Essentially every opcode maps to multiple potential polyfill names. For the
/// canonical encoding of these names, please check the function generating the
/// name in question, as the rules are not entirely standardized between
/// polyfill types.
#[derive(Clone, Debug, PartialEq)]
pub struct PolyfillMap {
    mapping: PolyMapping,
}

impl PolyfillMap {
    /// Instantiates a new polyfill mapping containing the polyfill definitions
    /// _required_ for compilation.
    #[must_use]
    pub fn new() -> Self {
        let mapping = PolyMapping::new();
        let mut polyfills = Self { mapping };

        polyfills.all_unary_ops();
        polyfills.all_binary_ops();
        polyfills.all_bitwise_binary_ops();
        polyfills.all_memory_ops();
        polyfills.all_conversion_ops();
        polyfills.all_other_ops();
        polyfills.all_c_intrinsics();
        polyfills.all_bit_intrinsics();
        polyfills.all_arith_with_overflow_intrinsics();
        polyfills.all_arith_with_sat_intrinsics();
        polyfills.all_fixed_point_arith_intrinsics();
        polyfills.all_specialized_arith_intrinsics();
        polyfills.all_hp_float_intrinsics();
        polyfills.all_sat_fptoi_conversions();

        polyfills
    }

    /// Gets an immutable iterator over the mapping pairs in this polyfill
    /// mapping.
    pub fn iter(&self) -> impl Iterator<Item = (&LLVMOperation, &String)> {
        self.mapping.iter()
    }

    /// Queries for the polyfill name that corresponds to the provided
    /// `name`, `param_types` and `return_type` returning it if it exists or
    /// returning [`None`] otherwise.
    #[must_use]
    pub fn get_polyfill(
        &self,
        name: &str,
        param_types: &[LLVMType],
        return_type: &LLVMType,
    ) -> Option<&String> {
        let op = LLVMOperation {
            opcode_name:   name.to_string(),
            operand_types: param_types.to_vec(),
            return_type:   return_type.clone(),
        };

        self.mapping.get(&op)
    }

    /// Queries for the polyfill name that corresponds to the provided
    /// `name`, `param_types` and `return_type` returning it if it exists or
    /// returning an error otherwise.
    ///
    /// # Errors
    ///
    /// - [`Error::MissingPolyfill`] if the requested polyfill does not exist.
    pub fn try_get_polyfill(
        &self,
        name: &str,
        param_types: &[LLVMType],
        return_type: &LLVMType,
    ) -> Result<&String> {
        self.get_polyfill(name, param_types, return_type).ok_or_else(|| {
            let function_type = LLVMType::make_function(return_type.clone(), param_types);
            Error::missing_polyfill(name, &function_type.to_string())
        })
    }

    /// Queries for the polyfill name that corresponds to the provided
    /// `name`, `param_types` and `return_type` returning it if it exists.
    ///
    /// # Panics
    ///
    /// If no polyfill exists for the provided combination of `name`,
    /// `param_types` and `return_type`.
    #[must_use]
    pub fn expect_polyfill(
        &self,
        name: &str,
        param_types: &[LLVMType],
        return_type: &LLVMType,
    ) -> &String {
        self.get_polyfill(name, param_types, return_type)
            .unwrap_or_else(|| panic!("{name} polyfill was not present"))
    }
}

/// Functionality useful for testing and experimenting with this container.
#[cfg(test)]
impl PolyfillMap {
    /// Instantiates an empty polyfill mapping.
    ///
    /// This **should never be used** in the compiler itself, and exists only
    /// for testing.
    #[must_use]
    pub fn empty() -> Self {
        let mapping = PolyMapping::new();
        Self { mapping }
    }

    /// Adds a specified `operation` and polyfill name pair to the map for
    /// testing purposes.
    pub fn insert(&mut self, operation: LLVMOperation, poly_name: &str) {
        self.mapping.insert(operation, poly_name.to_string());
    }
}

/// The definition of the [unary operations](https://llvm.org/docs/LangRef.html#unary-operations).
impl PolyfillMap {
    fn all_unary_ops(&mut self) {
        self.fneg();
    }

    fn fneg(&mut self) {
        for typ in Self::float_types() {
            self.mk("fneg", &[typ.clone()], typ.clone());
        }
    }
}

/// The definition of the [binary operations](https://llvm.org/docs/LangRef.html#binary-operations).
impl PolyfillMap {
    binop!(add, integer_types);

    binop!(fadd, float_types);

    binop!(sub, integer_types);

    binop!(fsub, float_types);

    binop!(mul, integer_types);

    binop!(fmul, float_types);

    binop!(udiv, integer_types);

    binop!(sdiv, integer_types);

    binop!(fdiv, float_types);

    binop!(urem, integer_types);

    binop!(srem, integer_types);

    binop!(frem, float_types);

    fn all_binary_ops(&mut self) {
        self.add();
        self.fadd();
        self.sub();
        self.fsub();
        self.mul();
        self.fmul();
        self.udiv();
        self.sdiv();
        self.fdiv();
        self.urem();
        self.srem();
        self.frem();
    }
}

/// The definition of the [bitwise binary operations](https://llvm.org/docs/LangRef.html#bitwise-binary-operations).
impl PolyfillMap {
    binop!(shl, integer_types);

    binop!(lshr, integer_types);

    binop!(ashr, integer_types);

    binop!(and, integer_types);

    binop!(or, integer_types);

    binop!(xor, integer_types);

    fn all_bitwise_binary_ops(&mut self) {
        self.shl();
        self.lshr();
        self.ashr();
        self.and();
        self.or();
        self.xor();
    }
}

/// The definition of the [memory access and addressing operations](https://llvm.org/docs/LangRef.html#memory-access-and-addressing-operations).
impl PolyfillMap {
    fn alloca(&mut self) {
        // The first argument is the size, in felts, of the allocation, while the second
        // argument is the number of instances of that size to allocate.
        self.mk("alloca", &[LLVMType::i64, LLVMType::i64], LLVMType::ptr);
    }

    // TODO composites via iteration. load_* for each prim type, taking an offset
    // from the ptr and the ptr. Need to fix insertvalue and extractvalue. Use
    // construct and destructure to deal with these things.

    fn load(&mut self) {
        // Due to the nature of the types available in FLO, we can only load and store
        // PRIMITIVE types. To that end, we need a load variant for _each_ primitive
        // type, and we have to decompose loads and stores of aggregates into loads and
        // stores using primitive types.

        // Our load function takes the pointer to load and an offset (in felts) from
        // that pointer, and returns the result of loading from that pointer.
        for typ in Self::numptr_types() {
            self.mk("load", &[LLVMType::ptr, LLVMType::i64], typ);
        }
    }

    fn store(&mut self) {
        // Due to the nature of the types available in FLO, we can only load and store
        // PRIMITIVE types. To that end, we need a load variant for _each_ primitive
        // type, and we have to decompose loads and stores of aggregates into loads and
        // stores using primitive types.

        // Our store function takes the value to store, the pointer to store it at, and
        // an offset (in felts) from that pointer at which the primitive value should be
        // stored.
        for typ in Self::numptr_types() {
            self.mk(
                "store",
                &[typ, LLVMType::ptr, LLVMType::i64],
                LLVMType::void,
            );
        }
    }

    fn cmpxchg(&mut self) {
        for typ in Self::intptr_types() {
            self.mk(
                "cmpxchg",
                &[LLVMType::ptr, typ.clone(), typ.clone()],
                LLVMType::make_struct(false, &[typ.clone(), LLVMType::bool]),
            );
        }
    }

    fn atomicrmw(&mut self) {
        let op_name = "atomicrmw";

        // Some of the ops are available to numeric types and pointers
        let numptr_ops = vec!["xchg"];
        for op in numptr_ops {
            for typ in Self::numptr_types() {
                let op_name = format!("{op_name}_{op}");
                self.mk(&op_name, &[LLVMType::ptr, typ.clone()], typ.clone());
            }
        }

        // The vast majority are available only to integer types.
        #[rustfmt::skip]
        let int_ops = vec![
            "add", "sub",  "and",  "nand",      "or",        "xor",       "max",
            "min", "umax", "umin", "uinc_wrap", "udec_wrap", "usub_cond", "usub_sat",
        ];
        for op in int_ops {
            for typ in Self::integer_types() {
                let op_name = format!("{op_name}_{op}");
                self.mk(&op_name, &[LLVMType::ptr, typ.clone()], typ.clone());
            }
        }

        // The remaining are available to float types.
        let float_ops = vec!["fadd", "fsub", "fmax", "fmin"];
        for op in float_ops {
            for typ in Self::float_types() {
                let op_name = format!("{op_name}_{op}");
                self.mk(&op_name, &[LLVMType::ptr, typ.clone()], typ.clone());
            }
        }
    }

    fn getelementptr(&mut self) {
        // This takes a pointer to an aggregate (either an array or a struct), and the
        // offset (in felts) within that pointer that corresponds to the target element.
        // It then returns a pointer to that element.
        //
        // This can only work at a single level, and so any usage needs to decompose
        // this.
        self.mk(
            "getelementptr",
            &[LLVMType::ptr, LLVMType::i64],
            LLVMType::ptr,
        );
    }

    fn all_memory_ops(&mut self) {
        self.alloca();
        self.load();
        self.store();
        self.cmpxchg();
        self.atomicrmw();
        self.getelementptr();
    }
}

/// The definition of the [conversion operations](https://llvm.org/docs/LangRef.html#conversion-operations).
impl PolyfillMap {
    fn trunc_op(&mut self) {
        for source_ty in Self::integer_types().iter().rev() {
            for target_ty in Self::integer_types().iter().take_while(|ty| *ty != source_ty) {
                let op = LLVMOperation::of("trunc", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_trunc_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn zext(&mut self) {
        for source_ty in Self::integer_types() {
            for target_ty in Self::integer_types()
                .iter()
                .skip_while(|ty| *ty != &source_ty)
                .skip(1)
            {
                let op = LLVMOperation::of("zext", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_zext_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn sext(&mut self) {
        for source_ty in Self::integer_types() {
            for target_ty in Self::integer_types()
                .iter()
                .skip_while(|ty| *ty != &source_ty)
                .skip(1)
            {
                let op = LLVMOperation::of("sext", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_sext_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn fptrunc(&mut self) {
        for source_ty in Self::float_types().iter().rev() {
            for target_ty in Self::float_types().iter().take_while(|ty| *ty != source_ty) {
                let op = LLVMOperation::of("fptrunc", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_fptrunc_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn fpext(&mut self) {
        for source_ty in Self::float_types() {
            for target_ty in Self::float_types().iter().skip_while(|ty| *ty != &source_ty).skip(1) {
                let op = LLVMOperation::of("fpext", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_fpext_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn fptoui(&mut self) {
        for source_ty in Self::float_types() {
            for target_ty in Self::integer_types() {
                let op = LLVMOperation::of("fptoui", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_fptoui_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn fptosi(&mut self) {
        for source_ty in Self::float_types() {
            for target_ty in Self::integer_types() {
                let op = LLVMOperation::of("fptosi", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_fptosi_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn uitofp(&mut self) {
        for source_ty in Self::integer_types() {
            for target_ty in Self::float_types() {
                let op = LLVMOperation::of("uitofp", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_uitofp_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn sitofp(&mut self) {
        for source_ty in Self::integer_types() {
            for target_ty in Self::float_types() {
                let op = LLVMOperation::of("sitofp", &[source_ty.clone()], target_ty.clone());
                let name = format!("__llvm_sitofp_{source_ty}_to_{target_ty}");
                self.mapping.insert(op, name);
            }
        }
    }

    fn ptrtoint(&mut self) {
        for target_ty in Self::integer_types() {
            let source_ty = LLVMType::ptr;
            let op = LLVMOperation::of("ptrtoint", &[source_ty.clone()], target_ty.clone());
            let name = format!("__llvm_ptrtoint_{source_ty}_to_{target_ty}");
            self.mapping.insert(op, name);
        }
    }

    fn inttoptr(&mut self) {
        for source_ty in Self::integer_types() {
            let target_ty = LLVMType::ptr;
            let op = LLVMOperation::of("inttoptr", &[source_ty.clone()], target_ty.clone());
            let name = format!("__llvm_inttoptr_{source_ty}_to_{target_ty}");
            self.mapping.insert(op, name);
        }
    }

    fn all_conversion_ops(&mut self) {
        self.trunc_op();
        self.zext();
        self.sext();
        self.fptrunc();
        self.fpext();
        self.fptoui();
        self.fptosi();
        self.uitofp();
        self.sitofp();
        self.ptrtoint();
        self.inttoptr();
    }
}

/// The definition of the [other instructions](https://llvm.org/docs/LangRef.html#other-operations).
impl PolyfillMap {
    fn icmp(&mut self) {
        let ops = vec![
            "eq", "ne", "ugt", "uge", "ult", "ule", "sgt", "sge", "slt", "sle",
        ];

        for op in ops {
            let name = format!("icmp_{op}");
            for typ in Self::intptr_types() {
                self.mk(&name, &[typ.clone(), typ.clone()], LLVMType::bool);
            }
        }
    }

    fn fcmp(&mut self) {
        let ops = vec![
            "false", "oeq", "ogt", "oge", "olt", "ole", "one", "ord", "ueq", "ugt", "uge", "ult",
            "ule", "une", "uno", "true",
        ];

        for op in ops {
            let name = format!("fcmp_{op}");
            for typ in Self::float_types() {
                self.mk(&name, &[typ.clone(), typ.clone()], LLVMType::bool);
            }
        }
    }

    fn all_other_ops(&mut self) {
        self.icmp();
        self.fcmp();
    }
}

/// The definition of the [C/C++ library intrinsics](https://llvm.org/docs/LangRef.html#standard-c-c-library-intrinsics).
impl PolyfillMap {
    binary_intrinsic!(abs, integer_types);

    binary_intrinsic!(smax, integer_types);

    binary_intrinsic!(smin, integer_types);

    binary_intrinsic!(umax, integer_types);

    binary_intrinsic!(umin, integer_types);

    binary_intrinsic!(scmp, integer_types, LLVMType::i8);

    binary_intrinsic!(ucmp, integer_types, LLVMType::i8);

    unary_intrinsic!(sqrt, float_types);

    unary_intrinsic!(sin, float_types);

    unary_intrinsic!(cos, float_types);

    unary_intrinsic!(tan, float_types);

    unary_intrinsic!(asin, float_types);

    unary_intrinsic!(acos, float_types);

    unary_intrinsic!(atan, float_types);

    unary_intrinsic!(atan2, float_types);

    unary_intrinsic!(sinh, float_types);

    unary_intrinsic!(cosh, float_types);

    unary_intrinsic!(tanh, float_types);

    unary_intrinsic!(exp, float_types);

    unary_intrinsic!(exp2, float_types);

    unary_intrinsic!(exp10, float_types);

    unary_intrinsic!(log, float_types);

    unary_intrinsic!(log10, float_types);

    unary_intrinsic!(log2, float_types);

    unary_intrinsic!(fabs, float_types);

    binary_intrinsic!(minnum, float_types);

    binary_intrinsic!(maxnum, float_types);

    binary_intrinsic!(minimum, float_types);

    binary_intrinsic!(maximum, float_types);

    binary_intrinsic!(minimumnum, float_types);

    binary_intrinsic!(maximumnum, float_types);

    binary_intrinsic!(copysign, float_types);

    unary_intrinsic!(floor, float_types);

    unary_intrinsic!(ceil, float_types);

    unary_intrinsic!(trunc, float_types);

    unary_intrinsic!(rint, float_types);

    unary_intrinsic!(nearbyint, float_types);

    unary_intrinsic!(round, float_types);

    unary_intrinsic!(roundeven, float_types);

    fn memop(&mut self, name: &str) {
        let base_name = format!("llvm.{name}.p0.p0");
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{typ}");
            let arg_types = &[LLVMType::ptr, LLVMType::ptr, typ.clone(), LLVMType::bool];
            let return_type = LLVMType::void;
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn memset(&mut self, inline: bool) {
        let base_name = if inline {
            "llvm.memset.inline.p0"
        } else {
            "llvm.memset.p0"
        };
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{typ}");
            let arg_types = &[LLVMType::ptr, LLVMType::i8, typ.clone(), LLVMType::bool];
            let return_type = LLVMType::void;
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn powi(&mut self) {
        let base_name = "llvm.powi";
        for base_ty in Self::float_types() {
            for exponent_ty in Self::integer_types() {
                let name = format!("{base_name}.{}.{}", &base_ty, &exponent_ty);
                let arg_types = &[base_ty.clone(), exponent_ty.clone()];
                let return_type = base_ty.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    }

    fn sincos(&mut self) {
        let base_name = "llvm.sincos";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{typ}");
            let arg_types = &[typ.clone()];
            let return_type = LLVMType::make_struct(false, &[typ.clone(), typ.clone()]);
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn pow(&mut self) {
        let base_name = "llvm.pow";
        for base_ty in Self::float_types() {
            for exponent_ty in Self::float_types() {
                let name = format!("{base_name}.{}.{}", &base_ty, &exponent_ty);
                let arg_types = &[base_ty.clone(), exponent_ty.clone()];
                let return_type = base_ty.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    }

    fn ldexp(&mut self) {
        let base_name = "llvm.ldexp";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}.{}", &typ, LLVMType::i32);
            let arg_types = &[typ.clone(), LLVMType::i32];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn frexp(&mut self) {
        let base_name = "llvm.frexp";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}.{}", &typ, LLVMType::i32);
            let arg_types = &[typ.clone()];
            let return_type = LLVMType::make_struct(false, &[typ.clone(), LLVMType::i32]);
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn fma(&mut self) {
        let base_name = "llvm.fma";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone(), typ.clone()];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn round_to(&mut self, name: &str) {
        let base_name = format!("llvm.{name}");
        for source_typ in Self::float_types() {
            for target_typ in Self::integer_types() {
                let name = format!("{base_name}.{}.{}", &target_typ, &source_typ);
                let arg_types = &[source_typ.clone()];
                let return_type = target_typ.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(&base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    }

    fn all_c_intrinsics(&mut self) {
        self.abs();
        self.smax();
        self.smin();
        self.umax();
        self.umin();
        self.scmp();
        self.ucmp();
        self.memop("memcpy");
        self.memop("memcpy.inline");
        self.memop("memmove");
        self.memset(false);
        self.memset(true);
        self.sqrt();
        self.powi();
        self.sin();
        self.cos();
        self.tan();
        self.asin();
        self.acos();
        self.atan();
        self.atan2();
        self.sinh();
        self.cosh();
        self.tanh();
        self.sincos();
        self.pow();
        self.exp();
        self.exp2();
        self.exp10();
        self.ldexp();
        self.frexp();
        self.log();
        self.log10();
        self.log2();
        self.fma();
        self.fabs();
        self.minnum();
        self.maxnum();
        self.minimum();
        self.maximum();
        self.minimumnum();
        self.maximumnum();
        self.copysign();
        self.floor();
        self.ceil();
        self.trunc();
        self.rint();
        self.nearbyint();
        self.round();
        self.roundeven();
        self.round_to("lround");
        self.round_to("llround");
        self.round_to("lrint");
        self.round_to("llrint");
    }
}

/// The definition of the [bit manipulation intrinsics](https://llvm.org/docs/LangRef.html#bit-manipulation-intrinsics).
impl PolyfillMap {
    unary_intrinsic!(bitreverse, integer_types);

    unary_intrinsic!(bswap, integer_types);

    unary_intrinsic!(ctpop, integer_types);

    fn count_op(&mut self, name: &str) {
        let base_name = format!("llvm.{name}");
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), LLVMType::bool];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn fsh(&mut self, name: &str) {
        let base_name = format!("llvm.{name}");
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone(), typ.clone()];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_bit_intrinsics(&mut self) {
        self.bitreverse();
        self.bswap();
        self.ctpop();
        self.count_op("ctlz");
        self.count_op("cttz");
        self.fsh("fshl");
        self.fsh("fshr");
    }
}

/// The definition of the [arithmetic with overflow intrinsics](https://llvm.org/docs/LangRef.html#arithmetic-with-overflow-intrinsics).
impl PolyfillMap {
    fn arith_with_overflow(&mut self, name: &str) {
        let base_name = format!("llvm.{name}.with.overflow");
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone()];
            let return_type = LLVMType::make_struct(false, &[typ.clone(), LLVMType::bool]);
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_arith_with_overflow_intrinsics(&mut self) {
        self.arith_with_overflow("sadd");
        self.arith_with_overflow("uadd");
        self.arith_with_overflow("ssub");
        self.arith_with_overflow("usub");
        self.arith_with_overflow("smul");
        self.arith_with_overflow("umul");
    }
}

/// The definition of the [saturation arithmetic intrinsics](https://llvm.org/docs/LangRef.html#saturation-arithmetic-intrinsics).
impl PolyfillMap {
    fn arith_with_sat(&mut self, name: &str) {
        let base_name = format!("llvm.{name}.sat");
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone()];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_arith_with_sat_intrinsics(&mut self) {
        self.arith_with_sat("sadd");
        self.arith_with_sat("uadd");
        self.arith_with_sat("ssub");
        self.arith_with_sat("usub");
        self.arith_with_sat("sshl");
        self.arith_with_sat("ushl");
    }
}

/// The definition of the [fixed point arithmetic intrinsics](https://llvm.org/docs/LangRef.html#fixed-point-arithmetic-intrinsics).
impl PolyfillMap {
    fn fix_arith(&mut self, name: &str, saturating: bool) {
        let base_name = if saturating {
            format!("llvm.{name}.fix.sat")
        } else {
            format!("llvm.{name}.fix")
        };
        for typ in Self::integer_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone(), LLVMType::i32];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(&base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_fixed_point_arith_intrinsics(&mut self) {
        self.fix_arith("smul", false);
        self.fix_arith("umul", false);
        self.fix_arith("smul", true);
        self.fix_arith("umul", true);
        self.fix_arith("sdiv", false);
        self.fix_arith("udiv", false);
        self.fix_arith("sdiv", true);
        self.fix_arith("udiv", true);
    }
}

/// The definition of the [specialized arithmetic intrinsics](https://llvm.org/docs/LangRef.html#specialized-arithmetic-intrinsics).
impl PolyfillMap {
    fn fmuladd(&mut self) {
        let base_name = "llvm.fmuladd";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone(), typ.clone(), typ.clone()];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_specialized_arith_intrinsics(&mut self) {
        self.fmuladd();
    }
}

/// The definition of the [half-precision floating-point intrinsics](https://llvm.org/docs/LangRef.html#half-precision-floating-point-intrinsics).
impl PolyfillMap {
    fn llvm_convert_to_f16(&mut self) {
        let base_name = "llvm.convert.to.fp16";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[typ.clone()];
            let return_type = LLVMType::f16;
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn llvm_convert_from_i16(&mut self) {
        let base_name = "llvm.convert.from.fp16";
        for typ in Self::float_types() {
            let name = format!("{base_name}.{}", &typ);
            let arg_types = &[LLVMType::f16];
            let return_type = typ.clone();
            let op = LLVMOperation::of(&name, arg_types, return_type);

            let polyfill_name = Self::polyfill_name(base_name, arg_types);

            self.mapping.insert(op, polyfill_name);
        }
    }

    fn all_hp_float_intrinsics(&mut self) {
        self.llvm_convert_to_f16();
        self.llvm_convert_from_i16();
    }
}

/// The definition of the [saturating floating point to integer conversions](https://llvm.org/docs/LangRef.html#saturating-floating-point-to-integer-conversions).
impl PolyfillMap {
    fn sat_conversion(&mut self, name: &str) {
        let base_name = format!("llvm.{name}.sat");
        for target_type in Self::integer_types() {
            for source_type in Self::float_types() {
                let name = format!("{base_name}.{}.{}", &target_type, &source_type);
                let arg_types = &[source_type.clone()];
                let return_type = target_type.clone();
                let op = LLVMOperation::of(&name, arg_types, return_type);

                let polyfill_name = Self::polyfill_name(&base_name, arg_types);

                self.mapping.insert(op, polyfill_name);
            }
        }
    }

    fn all_sat_fptoi_conversions(&mut self) {
        self.sat_conversion("fptoui");
        self.sat_conversion("fptosi");
    }
}

/// Useful static functions for dealing with polyfills.
impl PolyfillMap {
    pub fn mk(&mut self, name: &str, params: &[LLVMType], ret: LLVMType) {
        self.mapping.insert(
            LLVMOperation::of(name, params, ret),
            Self::polyfill_name(name, params),
        );
    }

    /// Generates the name for a polyfill for the provided `func_name` called
    /// with the provided `types`.
    #[must_use]
    pub fn polyfill_name(func_name: &str, types: &[LLVMType]) -> String {
        let types_str = if types.is_empty() {
            "void".to_string()
        } else {
            types.iter().map(std::string::ToString::to_string).join("_")
        };

        let func_name_no_dots = func_name.replace('.', "_").replace("llvm_", "");

        format!("__llvm_{func_name_no_dots}_{types_str}")
    }

    /// Gets the types that we want to generate integer operations over.
    #[must_use]
    pub fn integer_types() -> Vec<LLVMType> {
        vec![
            LLVMType::bool,
            LLVMType::i8,
            LLVMType::i16,
            LLVMType::i32,
            LLVMType::i64,
            LLVMType::i128,
        ]
    }

    /// Gets the types that we want to generate floating-point operations over.
    #[must_use]
    pub fn float_types() -> Vec<LLVMType> {
        vec![LLVMType::f16, LLVMType::f32, LLVMType::f64]
    }

    /// Gets all the numeric types that we want to potentially generate
    /// operations over.
    #[must_use]
    pub fn numeric_types() -> Vec<LLVMType> {
        let mut int_types = Self::integer_types();
        int_types.extend(Self::float_types());

        int_types
    }

    /// Gets all the integer types as well as the pointer type.
    #[must_use]
    pub fn intptr_types() -> Vec<LLVMType> {
        let mut int_types = Self::integer_types();
        int_types.push(LLVMType::ptr);
        int_types
    }

    /// Gets all the numeric types as well as the pointer type.
    #[must_use]
    pub fn numptr_types() -> Vec<LLVMType> {
        let mut num_types = Self::numeric_types();
        num_types.push(LLVMType::ptr);
        num_types
    }
}

impl Default for PolyfillMap {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod test {
    use crate::{llvm::typesystem::LLVMType, polyfill::PolyfillMap};

    #[test]
    fn polyfill_lookup_works() {
        let map = PolyfillMap::new();
        let polyfill = map.get_polyfill(
            "llvm.uadd.with.overflow.i64",
            &[LLVMType::i64, LLVMType::i64],
            &LLVMType::make_struct(false, &[LLVMType::i64, LLVMType::bool]),
        );

        assert!(polyfill.is_some());
        let name = polyfill.unwrap();

        assert_eq!(name, "__llvm_uadd_with_overflow_i64_i64");
    }

    #[test]
    fn has_correct_polyfill_count() {
        let polyfills = PolyfillMap::new();
        let count = polyfills.iter().count();
        assert_eq!(count, 970);
    }
}
