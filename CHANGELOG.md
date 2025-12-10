# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.8.3] - 2025-12-10

### Deployment
- Update v1.8.3

### Fixed
- Esc only terminates the current function, not the entire script.


## [1.8.2] - 2025-12-10

### Added
- (make-executable module) only makes scripts with known script extensions executable


## [1.8.1] - 2025-12-10

### Added
- Update check added after installation


## [1.8.0] - 2025-12-10

### Documentation
- Update  the readme file on version creation

### Added
- Add make-executable module


## [1.7.4] - 2025-11-25

### Fixed
- get local Version from lib-file


## [1.7.3] - 2025-11-25

### Fixed
- Correct Debian version format


## [1.7.2] - 2025-11-25

### Fixed
- Correct Debian version format and move update notification into user cache


## [1.7.1] - 2025-11-25

### Fixed
- Update module was not installed


## [1.7.0] - 2025-11-25

### Deployment
- prepare Release 1.7.0

### Added
- Add interactive cronjob installation prompt in postinst
- Improve update flow with confirmation prompt and robust script checks
- Add automatic update-check module


## [1.6.2] - 2025-11-25

### Documentation
- update CHANGELOG for v1.6.2

### Added
- CLI: add interactive update confirmation


## [1.6.1] - 2025-11-25

### Documentation
- update CHANGELOG for v1.6.1

### Chore
- use local Bash-utils in release process
- Build Debian Package in tmp folder and cleanup


## [1.6.0] - 2025-11-25

### Documentation
- Update the installation instructions for the Debian package using wget

### Added
- Add fallback for update check using curl if gh CLI is missing


## [1.5.2] - 2025-11-25

### Deployment
- Prepare new release

### Chore
- Update Release-process


## [1.5.0] - 2025-11-25
### Changed
- own directory for packaging

### Fixed
- Build Debian has bad substitution

---

## [1.4.0] - 2025-11-24
### Added
- Add CLI wrapper for bash-utils with --version support
- Add auto-update functionality for bash-utils
- Add centralized version handling and auto-versioned release workflow

### Chore
- add enhanced release.sh with commit-type sorting

---

## [1.3.0] - 2025-11-24
### Added
- Add automated release script (release.sh) with GitHub + Debian support

---

## [1.2.0] – 2025-11-24
### Added
- Debian package support for easy installation on Ubuntu/Debian
- CRLF-Guardian tool: automatic path detection, CLI integration, scan & fix for Windows line endings
- README documentation for CRLF-Guardian added

---

## [1.1.0] – 2025-07-03
### Added
- UTF-8 compatible test mail function in core/email.sh
- Test script for `send_testmail` added
- Instructions for test mail with recipient parameters in README

### Fixed
- Email module loaded in lib.sh to enable test mail function

---

## [1.0.3] – 2025-06-05
### Added
- `.env` loader: safe use without overwriting existing variables

---

## [1.0.2] – 2025-05-21
### Added
- SKIP_DIRS flag for optional skipping of default directories
- Interactive menu navigation with escape cancellation and input check
- Improvements to menu input handling (confirmation required)
- Refactoring: lib.sh test-friendly, external variables are not overwritten

### Fixed
- Escape variables for `center_colored_text` corrected

### Changed
- Deprecation notice for old lib.sh entry points added
- Improved structuring of lib.sh, UI, and menu modules
- File helpers integrated into lib.sh

---

## [1.0.1] – 2025-05-20
### Added
- Improved project structure for reusable Bash modules
- Made menu module reusable
- Added file operations (`file_helpers`) to lib.sh

### Changed
- Updated readme

---

## [1.0.0] – 2025-04-24
### Added
- Initial Release: Global Bash helper functions for logging, colors, menus, validation
- Installation and uninstallation scripts
- Bash project generator
- Logging with icons, colors, file output
- `.env` handling for mandatory variables
- Core modules for colors, logging, validation, UI
- First version of test scripts
