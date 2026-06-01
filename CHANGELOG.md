# Changelog

## [3.0.0] - 01/Jun/2026

### Changed

- Migrated package to Dart 3.6+.
- Replaced static API (`MpesaConfig`, `MpesaTransaction`) with client-centric `MpesaClient`.
- Added immutable request models with constructor validation.
- Added typed response wrapper (`MpesaResult`) and normalized API response model (`MpesaApiResponse`).
- Added typed exception hierarchy for auth/api/network/serialization failures.
- Reworked README and example to the new v3 API.

### Added

- Unit and contract tests for models, crypto helper, and HTTP client behavior.
- Strict analyzer/lint configuration via `analysis_options.yaml`.
- GitHub Actions CI workflow with format, analyze, test, and coverage generation.

## [2.0.1] - 27/Mar/2021

### Added

- Example page

### Changed

- Refactor getBearerToken
- Refactor request headers

## [1.0.1] - 27/Mar/2021

### Added

- Null-safaty suport
- Example page

### Changed

- Outsourced `apiHost` to suport production keys.
- Enhanced architecture (file structure)
- Simplified RSA_HELPER

### removed

- Removed Credits in README

## [1.0.0] - 07/Jun/2020

### Added

- B2C transactions
- B2B transactions
- Reversal transactions
- Query transactions status
- Homepage config

### Changed

- Updated README

### Fixed

- Fix typos

### removed

- Usage of [new] keyword

## [0.0.1] - 05/Jun/2020

### Added

- Initial release
