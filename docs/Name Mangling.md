# Hieratika Name Mangling

We need to design a name mangling scheme for Hieratika to use. It should run on FLO's `Type` and
account for:

- Embedding type info (params and return type) for uniqueness.
- Embedding the function name.
- Embedding the module name.
