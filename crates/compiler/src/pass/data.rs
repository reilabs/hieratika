//! Pass data is data that results from the operation of some pass that _cannot_
//! be represented in the standard output of the pass.

use std::{
    any::{Any, TypeId},
    collections::HashMap,
    fmt::Debug,
};

use downcast_rs::Downcast;

use crate::{
    context::SourceContext,
    pass::{ConcretePass, PassKey, PassOps},
};

/// Pass data is output by any given pass
pub type PassData = Box<dyn PassDataOps>;

/// The operations that we expect one of our pass data objects to have.
///
/// The implementation is designed to be used via dynamic dispatch, and hence
/// can provide the requisite operations however it is able.
///
/// # Recommended Functions
///
/// On the concrete type that implements this trait, it is recommended to
/// implement:
///
/// - A `new(...) -> Self` associated function.
/// - A `new_dyn(...) -> PassData` associated function. This one can usually
///   simply call `Box::new(Self::new(...))`.
///
/// These aid in providing a uniform way to construct pass data.
///
/// # Self Bounds
///
/// The bounds on `Self` are required by these traits for the following reasons:
///
/// - [`Any`] allows downcasting to concrete implementations of `Opcode` if
///   needed.
/// - [`Debug`] to provide representations to aid in debugging. It is
///   recommended to use the derive feature for this.
/// - [`Downcast`] for easy conversions _to_ [`Any`] for downcasting.
///
/// In addition, it is required but not enforced that implementors of this
/// trait also implement [`ConcretePassData`].
pub trait PassDataOps
where
    Self: Any + Debug + Downcast,
{
}

/// Operations implemented on `dyn PassDataOps` are **only** available on the
/// concrete trait object and hence not equivalent to a blanket implementation
/// of a method for `trait PassDataOps`.
impl dyn PassDataOps {
    /// Checks if the pass is an instance of the concrete pass `T`, returning
    /// `true` if it is and `false` otherwise.
    pub fn is<T: ConcretePassData>(&self) -> bool {
        self.as_any().is::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&T` if possible and `None` otherwise.
    pub fn view_as<T: ConcretePassData>(&self) -> Option<&T> {
        self.as_any().downcast_ref::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&mut T` if possible and `None` otherwise.
    pub fn view_as_mut<T: ConcretePassData>(&mut self) -> Option<&mut T> {
        self.as_any_mut().downcast_mut::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&T` if possible.
    ///
    /// # Panics
    ///
    /// If `self` is not `T`.
    pub fn unwrap_as<T: ConcretePassData>(&self) -> &T {
        self.view_as()
            .unwrap_or_else(|| panic!("self was not a {:?}", TypeId::of::<T>()))
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&mut T` if possible.
    ///
    /// # Panics
    ///
    /// If `self` is not `T`.
    pub fn unwrap_as_mut<T: ConcretePassData>(&mut self) -> &mut T {
        self.view_as_mut()
            .unwrap_or_else(|| panic!("self was not a {:?}", TypeId::of::<T>()))
    }
}

/// Provides additional operations that can be called when operating on a
/// concrete instance of a specific pass, rather than any pass instance.
///
/// # Recommended Functions
///
/// On the concrete type that implements this trait, it is recommended to
/// implement:
///
/// - A `new(...) -> Self` associated function.
/// - A `new_dyn(...) -> PassData` associated function. This one can usually
///   simply call `Box::new(Self::new(...))`.
///
/// These aid in providing a uniform way to construct pass data.
pub trait ConcretePassData
where
    Self: Clone + Debug + PassDataOps,
{
    /// The pass with which the data is associated.
    type Pass: ConcretePass;
}

/// An empty pass data that complies with the required [`PassData`] interface.
///
/// Some passes do not return any data, but due to the bounds required between
/// passes and their data we cannot trivially just use `()` or similar types. To
/// that end, this type exists to represent that empty case.
#[derive(Clone, Debug, PartialEq)]
pub struct EmptyPassData<T> {
    /// Ensures that we actually use the type parameter `T`.
    _marker: std::marker::PhantomData<T>,
}

impl<T> EmptyPassData<T> {
    /// Constructs a new instance of the empty pass data.
    #[must_use]
    pub fn new() -> Self {
        Self {
            _marker: std::marker::PhantomData,
        }
    }
}

impl<T> EmptyPassData<T>
where
    T: PassOps,
{
    /// Constructs a new dynamic instance of the empty pass data.
    #[must_use]
    pub fn new_dyn() -> Box<dyn PassDataOps> {
        Box::new(EmptyPassData::<T>::new())
    }
}

/// A blanket impl that allows it to be used with any pass.
impl<T> PassDataOps for EmptyPassData<T> where T: PassOps {}

/// A blanket impl that allows it to be used with any pass.
impl<T> ConcretePassData for EmptyPassData<T>
where
    T: ConcretePass,
{
    type Pass = T;
}

/// A simple empty default for the empty pass data.
impl<T> Default for EmptyPassData<T> {
    fn default() -> Self {
        Self::new()
    }
}

/// Pass return data that returns a dynamic [`PassData`].
pub type DynPassReturnData = PassReturnData<PassData>;

/// The data returned when executing a pass.
#[derive(Debug)]
pub struct PassReturnData<T> {
    /// The newly-modified source context.
    pub source_context: SourceContext,

    /// The data returned by the pass.
    pub data: T,
}
impl<T> PassReturnData<T> {
    /// Creates a new instance of the pass return data.
    pub fn new(source_context: SourceContext, data: T) -> Self {
        Self {
            source_context,
            data,
        }
    }
}

impl PassReturnData<PassData> {
    /// Allows you to get the returned pass data as the concrete data type `T`,
    /// returning `&T` if possible and `None` otherwise.
    #[must_use]
    pub fn data_as<T: ConcretePassData>(&self) -> Option<&T> {
        self.data.as_any().downcast_ref::<T>()
    }

    /// Allows you to get the returned pass data as the concrete data type `T`,
    /// returning `&T` if possible and `None` otherwise.
    pub fn data_as_mut<T: ConcretePassData>(&mut self) -> Option<&mut T> {
        self.data.as_any_mut().downcast_mut::<T>()
    }

    /// Allows you to get the returned pass data as the concrete data type `T`,
    /// returning `&T` if possible.
    ///
    /// # Panics
    ///
    /// If `self.data` is not an instance of `T`.
    #[must_use]
    pub fn unwrap_data_as<T: ConcretePassData>(&self) -> &T {
        self.data_as::<T>().unwrap()
    }

    /// Allows you to get the returned pass data as the concrete data type `T`,
    /// returning `&mut T` if possible.
    ///
    /// # Panics
    ///
    /// If `self.data` is not an instance of `T`.
    pub fn unwrap_data_as_mut<T: ConcretePassData>(&mut self) -> &mut T {
        self.data_as_mut::<T>().unwrap()
    }
}

/// A mapping from pass keys to the associated pass data.
///
/// It will always contain the latest pass data, as there is no need to re-run a
/// pass unless it was invalidated by a subsequent pass.
pub type DynPassDataMap = PassDataMap<PassData>;

/// A mapping from pass keys to the associated pass data.
///
/// It will always contain the latest pass data, as there is no need to re-run a
/// pass unless it was invalidated by a subsequent pass.
#[derive(Clone, Debug, PartialEq)]
pub struct PassDataMap<T> {
    /// The mapping from pass keys to pass data.
    mapping: HashMap<PassKey, T>,
}

impl<T> PassDataMap<T> {
    /// Constructs a new, empty, mapping from pass keys to pass data.
    #[must_use]
    pub fn new() -> Self {
        let mapping = HashMap::new();
        Self { mapping }
    }

    /// Clears all pass data.
    pub fn clear_all(&mut self) {
        self.mapping.clear();
    }

    /// Gets a reference to the last-written data for the pass given by the
    /// provided `key` if it exists, and returns `None` otherwise.
    #[must_use]
    pub fn get_key(&self, key: PassKey) -> Option<&T> {
        self.mapping.get(&key)
    }

    /// Gets a reference to the last-written data for the pass given by the
    /// provided `key`.
    ///
    /// # Panics
    ///
    /// - If no data exists for the pass described by `key`.
    #[must_use]
    pub fn expect_key(&self, key: PassKey) -> &T {
        self.mapping
            .get(&key)
            .unwrap_or_else(|| panic!("Pass data was not found for the pass with key {key:?}"))
    }

    /// Writes the provided `data` into the container associating it with the
    /// pass described by `key`, overwriting any existing data for that pass.
    pub fn put_key(&mut self, key: PassKey, data: T) {
        self.mapping.insert(key, data);
    }

    /// Clears the data for the pass given by the provided `key`, if it exists.
    pub fn clear_key(&mut self, key: PassKey) {
        self.mapping.remove(&key);
    }
}

impl PassDataMap<PassData> {
    /// Gets a reference to the last-written data for the pass `P` if it exists,
    /// and returns `None` otherwise.
    ///
    /// The data returned is returned as the concrete type.
    #[must_use]
    pub fn get<P: ConcretePass>(&self) -> Option<&P::Data> {
        self.get_key(P::key())?.view_as::<P::Data>()
    }

    /// Gets a reference to the last-written data for the pass `P`.
    ///
    /// # Panics
    ///
    /// - If no data exists for the pass `P`.
    #[must_use]
    pub fn expect<P: ConcretePass>(&self) -> &P::Data {
        // This unwrap is safe as retrieving data from that pass has a static guarantee
        // that it is the correct type.
        self.get_key(P::key())
            .unwrap_or_else(|| {
                let data_name = std::any::type_name::<P::Data>();
                panic!("{data_name} was not available")
            })
            .view_as::<P::Data>()
            .unwrap_or_else(|| unreachable!("Statically-constrained type was not correct"))
    }

    /// Writes the provided `data` into the container associating it with the
    /// pass `P`, overwriting any existing data for that pass.
    ///
    /// This expects the data to be the concrete pass data type for the pass in
    /// question.
    pub fn put<P: ConcretePass>(&mut self, data: P::Data) {
        let data = Box::new(data);
        self.put_key(P::key(), data);
    }

    /// Clears the data for the pass `P` if it exists.
    pub fn clear<P: ConcretePass>(&mut self) {
        self.clear_key(P::key());
    }
}

impl<T> Default for PassDataMap<T> {
    fn default() -> Self {
        Self::new()
    }
}
