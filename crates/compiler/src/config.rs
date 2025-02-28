//! The compiler's configuration, which specifies portions of the compiler's
//! behavior at runtime.

use crate::polyfill::PolyfillMap;

/// The configuration for the compiler.
#[derive(Debug)]
pub struct CompilerConfig {
    /// The set of polyfills to be made available in this compilation.
    pub polyfills: PolyfillMap,
}

/// The default configuration for the compiler.
impl Default for CompilerConfig {
    fn default() -> Self {
        Self {
            polyfills: PolyfillMap::default(),
        }
    }
}
