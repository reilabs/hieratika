//! Data structures supporting tables of interned objects.
//!
//! These tables form the 'sections' of our FLOs.

use std::{collections::HashMap, hash::Hash};

use serde::{Deserialize, Serialize};

use crate::{poison::Poisonable, types::PoisonType};

/// The type for all integer-based identifiers used in the interning logic.
pub(crate) type InternIdentifier = usize;

/// The special table value that always contains a poisoned element.
#[expect(clippy::unreadable_literal)]
const POISON_ENTRY: usize = 0xdecea5ed;

/// A type for generic tables of interned objects.
///
/// It is used to store these objects as part of the `FlatLoweredObject` file,
/// and to make them able to be referenced as needed.
#[derive(Serialize, Deserialize, Debug, PartialEq, Eq)]
pub struct InternTable<IdType, ValueType>
where
    IdType: Eq + Hash + From<usize> + Into<usize> + Copy,
    ValueType: Poisonable + Clone,
{
    // The internal bidirectional hash-map used for interning.
    table: HashMap<usize, ValueType>,

    // The next ID to be assigned.
    next_id: usize,

    // Mark our IdType as used.
    _phantom: std::marker::PhantomData<IdType>,
}

impl<IdType, ValueType> InternTable<IdType, ValueType>
where
    IdType: Eq + Hash + From<usize> + Into<usize> + Copy,
    ValueType: Poisonable + Clone,
{
    /// Creates a new intern table.
    #[must_use]
    pub fn new() -> InternTable<IdType, ValueType> {
        let mut s = InternTable {
            // Start our IDs at one, as we've reserved 0.
            table:   HashMap::new(),
            next_id: 1,

            _phantom: std::marker::PhantomData,
        };

        // Allocate our two special IDs.
        s.table.insert(
            0,
            ValueType::get_poison_value(PoisonType::NullInternedValue),
        );
        s.table.insert(
            POISON_ENTRY,
            ValueType::get_poison_value(PoisonType::Undefined),
        );

        s
    }

    /// Reserves a new "slot" in the intern table by finding the next
    /// available integer ID.
    fn allocate_id(&mut self) -> usize {
        // Get the next ID in our table.
        let allocated_id = self.next_id;
        let mut next_id = allocated_id + 1;

        // If this ID happens to be taken, move to the next one until we find a free ID.
        while self.table.contains_key(&next_id) {
            next_id += 1;
        }

        // Store our new successor ID, and return the allocated one.
        self.next_id = next_id;
        allocated_id
    }

    /// Inserts a new value into the intern table, getting its ID.
    pub fn insert(&mut self, v: &ValueType) -> IdType {
        // Place the object into a new slot...
        let id = self.allocate_id();

        self.table.insert(id, v.clone());

        // ... and return the allocated ID.
        id.into()
    }

    /// Retrieves a value from the intern table by ID.
    ///
    /// # Panics
    ///
    /// Panics if the ID does not exist. This is a programmer error.
    pub fn get(&self, id: IdType) -> ValueType {
        let raw_id: usize = id.into();
        self.table
            .get(&raw_id)
            .unwrap_or_else(|| {
                panic!("internal consistency error: get with an unknown ID {raw_id}!")
            })
            .clone()
    }

    /// Gets the identifier for the table's poisoned entry.
    #[must_use]
    pub fn get_poison(&self) -> IdType {
        POISON_ENTRY.into()
    }

    /// Places a value into the intern table at a given ID, which _must_
    /// have already been allocated by a previous call to `insert()`.
    ///
    /// # Panics
    ///
    /// Panics if the relevant ID is not present. This is a programmer error.
    pub fn swap(&mut self, id: IdType, value: &ValueType) -> ValueType {
        let raw_id: usize = id.into();

        // Update both sides of the table.
        let previous = self.table.insert(raw_id, value.clone());

        previous.expect("internal consistency error: swap called on an unknown ID!")
    }

    /// Gets an immutable iterator over the entries in the table.
    ///
    /// Please note that neither the zero entry nor the poison entry will be
    /// an element seen in the iterator, and so it is not recommended to
    /// construct a new `InternTable` by `collect`ing this iterator.
    pub fn iter(&self) -> impl Iterator<Item = (&usize, &ValueType)> {
        self.table.iter().filter(|(id, _)| **id != POISON_ENTRY && **id != 0)
    }

    /// Gets an immutable iterator over the _keys_ for the provided table.
    #[must_use]
    pub fn ids(&self) -> Vec<usize> {
        self.table
            .keys()
            .copied()
            .filter(|id| *id != POISON_ENTRY && *id != 0)
            .collect()
    }
}

impl<IdType, ValueType> Default for InternTable<IdType, ValueType>
where
    IdType: Eq + Hash + From<usize> + Into<usize> + Copy,
    ValueType: Poisonable + Clone,
{
    fn default() -> Self {
        Self::new()
    }
}

impl<IdType, ValueType> InternTable<IdType, ValueType>
where
    IdType: Eq + Hash + From<usize> + Into<usize> + Copy,
    ValueType: Poisonable + Clone + Default,
{
    /// Inserts a new element into the table with the default value for the
    /// table-element's type. Excellent for creating placeholders to be
    /// filled later.
    ///
    /// Note that for most of the FLO types, this will return an uninitialized/
    /// poisoned object, which you may wat to unpoison on initialization.
    pub fn insert_default(&mut self) -> IdType {
        self.insert(&ValueType::default())
    }
}

// Tests.
//

#[cfg(test)]
#[expect(
    clippy::cast_possible_truncation,
    clippy::needless_range_loop,
    clippy::unreadable_literal
)]
mod tests {
    use super::{InternIdentifier, InternTable};
    use crate::poison::Poisonable;

    // For testing, make a synthetic poisonable type out of Vec<u32>.
    impl Poisonable for Vec<u32> {
        fn get_poison_value(_typ: crate::types::PoisonType) -> Self {
            vec![0xabad_cafe]
        }

        fn is_poisoned(value: &Self) -> bool {
            (*value) == vec![0xabad_cafe]
        }
    }

    /// Generates our sample unit under test, with some simple initialization.
    fn get_uut() -> InternTable<InternIdentifier, Vec<u32>> {
        InternTable::new()
    }

    #[test]
    fn added_elements_can_be_retreived() {
        let mut uut = get_uut();
        let mut indices: Vec<InternIdentifier> = vec![];

        // Populate a bunch of elements.
        for i in 0..100 {
            let index = uut.insert(&vec![i]);
            indices.push(index);

            assert_ne!(
                index,
                super::POISON_ENTRY,
                "should never get index {index}, the poison entry!"
            );
            assert_ne!(index, 0, "should never get index {index}, the null entry!");
        }

        // Check back their values.
        for i in 0..100 {
            let index = indices[i];

            assert_eq!(
                vec![i as u32],
                uut.get(index),
                "stored {:?} in index {}, but got back {:?}",
                vec![i],
                index,
                uut.get(index)
            );
        }

        // Check that value semantics work.
        let index = indices[0];

        uut.get(index).push(0x600dcafe);
        assert_eq!(vec![0], uut.get(index));
    }

    #[test]
    fn swap_replaces_elements() {
        let mut uut = get_uut();

        // Add two sample values.
        let index_a = uut.insert(&vec![0xcccc_cccc]);
        let index_b = uut.insert(&vec![0xbbbb_bbbb]);

        // Tweak the first value...
        let prior = uut.swap(index_a, &vec![0xaaaa_aaaa]);
        assert_eq!(
            prior,
            vec![0xcccc_cccc],
            "swap should return the prior value"
        );

        // The value changed should have changed; the other vlaue should not have.
        assert_eq!(
            uut.get(index_a),
            vec![0xaaaa_aaaa],
            "swap() should update values!"
        );
        assert_eq!(
            uut.get(index_b),
            vec![0xbbbb_bbbb],
            "swap() should update values!"
        );
    }

    #[test]
    #[should_panic(expected = "internal consistency error: get with an unknown ID 1234!")]
    fn getting_a_nonexistent_index_should_panic() {
        get_uut().get(1234);
    }

    #[test]
    fn special_values_should_exist_and_be_poisoned() {
        let uut = get_uut();

        assert_eq!(
            uut.get(0),
            Vec::<u32>::get_poison_value(crate::types::PoisonType::NullInternedValue)
        );
        assert_eq!(
            uut.get(super::POISON_ENTRY),
            Vec::<u32>::get_poison_value(crate::types::PoisonType::Undefined)
        );
    }
}
