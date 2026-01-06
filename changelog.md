# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https.md//keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https.md//semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-07-31

### Added

- Initial project setup.
- Singularity definition file (`image.def`) to build the container environment.
- Base environment using `python:3.12-slim`.
- Integration of `uv` for fast Python package management.
- Installation of Jupyter Notebook.
- Installation of `.NET 10 SDK` and `.NET Interactive`.
- Support for polyglot notebooks (C#, F#, PowerShell) within Jupyter.
- `makefile` with `build` and `run` targets for easy management.
- `starship` prompt for a rich console experience.
- Initial `README.md`, `license.txt`, and `changelog.md`.
