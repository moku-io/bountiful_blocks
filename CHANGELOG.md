# Changelog

<!--[//]: # (
## <Release number> <Date YYYY-MM-DD>
### Breaking changes
### Deprecations
### New features
### Bug fixes
)-->

## 1.1.1 2023-10-12

### New features

- Added `given_blocks!` utility method.

### Bug fixes

- The `given!` utility method was never filled during instantiation, now it works as described.
- Trying to invoke a block that was not passed now produces `NoMethodError` instead of `FrozenError`.

## 1.1.0 2023-09-07

### New features

- Added `raw!`, `given!`, and `call_all!` utility methods.
- Now multiblocks are always frozen after construction.
- Added RBS type signatures.

### Bug fixes

- Fixed enforcing of block names limitations.
- Removed the `Error` class.

## 1.0.0 2023-05-30

First release. Refer to [README.md](README.md) for the full documentation.
