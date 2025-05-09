//! This module contains constants that specify portions of the mangling
//! behavior.

use std::sync::LazyLock;

use regex::Regex;

/// A marker used to separate sections in the mangled string.
pub const SECTION_SEPARATOR: &str = "$";

/// A marker used to separate sections in the mangled string when compatibility
/// with source-level Cairo is required.
pub const SECTION_SEPARATOR_CAIRO: &str = "___";

/// A marker used to replace a character in any user-provided string for
/// mangling that is disallowed in a Cairo identifier.
pub const INVALID_CAIRO_CHARACTER: &str = "_IC_";

/// A marker used to signify the beginning of a snapshot mangle segment.
pub const BEGIN_SNAPSHOT: &str = "m";

/// A marker used to signify the beginning of an array.
pub const BEGIN_ARRAY: &str = "A";

/// A marker used to signify the beginning of a struct.
pub const BEGIN_STRUCT: &str = "S";

/// A marker used to signify the end of a struct.
pub const END_STRUCT: &str = "s";

/// A marker used to signify the beginning of an enum.
pub const BEGIN_ENUM: &str = "G";

/// A marker used to signify the end of an enum.
pub const END_ENUM: &str = "g";

/// The prefix for symbols that indicates that they are internal or reserved.
pub const INTERNAL_NAME_PREFIX: &str = "__";

/// The regex that matches on characters that are invalid to have in a Cairo
/// identifier.
pub static INVALID_CAIRO_CHARS_REGEX: LazyLock<Regex> =
    LazyLock::new(|| Regex::new("[^[A-Za-z0-9_-]]").expect("Hardcoded regex was not valid"));
