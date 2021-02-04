# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:
- Added support for PureScript 0.14 and dropped support for all previous versions (#35)
- Removed `Costrong` and `Cochoice` from `Costar` (#38)
- `Clown`, `Costar`, `Cowrap`, and `Joker` have been moved to the `Data.Functors` module in the `purescript-functors` package, so that the same types can also be used as bifunctors; `Cowrap` was renamed to `Flip` (#41)
- `Wrap` was deleted; it is expected that any instances of `Profunctor` will be accompanied by a corresponding instance of `Functor` (#41)

New features:
- This package no longer depends on the `purescript-contravariant` package (#41)

Bugfixes:

Other improvements:
- Migrated CI to GitHub Actions and updated installation instructions to use Spago (#36)
- Added a changelog and pull request template (#39, #40)

## [v4.1.0](https://github.com/purescript/purescript-profunctor/releases/tag/v4.1.0) - 2019-08-21

Added more instances for `Joker` (@masaeedu)

## [v4.0.0](https://github.com/purescript/purescript-profunctor/releases/tag/v4.0.0) - 2018-05-23

- Updated for PureScript 0.12
- `lmap` has been renamed to `lcmap` so as to avoid collisions with `Bifunctor`'s `lmap`, and for consistency with `cmap` for `Contravariant` functors

## [v3.2.0](https://github.com/purescript/purescript-profunctor/releases/tag/v3.2.0) - 2017-06-18

- Added `hoist` functions for the various newtypes, where appropriate

## [v3.1.0](https://github.com/purescript/purescript-profunctor/releases/tag/v3.1.0) - 2017-06-09

- Added `Clown`, `Joker`, `Join`, `Split`, `Wrap` and `Cowrap` newtypes

## [v3.0.0](https://github.com/purescript/purescript-profunctor/releases/tag/v3.0.0) - 2017-03-26

- Updated for PureScript 0.11

## [v2.0.0](https://github.com/purescript/purescript-profunctor/releases/tag/v2.0.0) - 2016-10-08

- Updated dependencies
- Added `wrapIso` and `unwrapIso`

## [v1.0.0](https://github.com/purescript/purescript-profunctor/releases/tag/v1.0.0) - 2016-06-01

This release is intended for the PureScript 0.9.1 compiler and newer. **Note**: The v1.0.0 tag is not meant to indicate the library is “finished”, the core libraries are all being bumped to this for the 0.9 compiler release so as to use semver more correctly.

- Fixed unused import warnings

## [v0.3.2](https://github.com/purescript/purescript-profunctor/releases/tag/v0.3.2) - 2016-01-03

Add `Closed`, `Costrong` and `Cochoice` (@zrho)

## [v0.3.1](https://github.com/purescript/purescript-profunctor/releases/tag/v0.3.1) - 2015-09-06

Add `Star`.

## [v0.3.0](https://github.com/purescript/purescript-profunctor/releases/tag/v0.3.0) - 2015-06-30

This release works with versions 0.7.\* of the PureScript compiler. It will not work with older versions. If you are using an older version, you should require an older, compatible version of this library.

## [v0.2.1](https://github.com/purescript/purescript-profunctor/releases/tag/v0.2.1) - 2015-03-19

Update docs

## [v0.2.0](https://github.com/purescript/purescript-profunctor/releases/tag/v0.2.0) - 2015-03-06

- Moved arrow combinators over (@paf31)

## [v0.1.0](https://github.com/purescript/purescript-profunctor/releases/tag/v0.1.0) - 2015-02-21

**This release requires PureScript v0.6.8 or later**
- Updated dependencies

## [v0.0.2](https://github.com/purescript/purescript-profunctor/releases/tag/v0.0.2) - 2015-01-08

- Initial release.
- Added `Choice` and `Strong` (@joneshf)

