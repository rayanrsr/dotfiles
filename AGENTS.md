# AGENTS.md

This file provides guidelines for AI coding agents operating within this repository.

## Build, Lint, and Test Commands

- **Build**: `make build` (in `exact_dot_fzf/`)
- **Lint**: `gofmt -s -d src` (in `exact_dot_fzf/`)
- **Test**: `make test` (in `exact_dot_fzf/` and `exact_dot_oh-my-zsh/exact_custom/exact_plugins/exact_zsh-autosuggestions/`)
- **Single Test**: `make test` (in `exact_dot_fzf/` and `exact_dot_oh-my-zsh/exact_custom/exact_plugins/exact_zsh-autosuggestions/` - specific test selection may require modifying the Makefile or test scripts).

## Code Style Guidelines

- **Formatting**: Adheres to Go standards (gofmt) and Zsh best practices.
- **Naming Conventions**: Follows Go conventions (camelCase for exported, PascalCase for unexported) and Zsh conventions (snake_case).
- **Imports**: Standard Go import organization. Zsh plugins manage their own imports within their respective directories.
- **Error Handling**: Go uses error return values. Zsh scripts rely on exit codes and conditional checks.
- **Types**: Go is statically typed. Zsh is dynamically typed.

## Cursor Rules

No specific Cursor rules found in `.cursor/rules/` or `.cursorrules`.

## Copilot Rules

No specific Copilot rules found in `.github/copilot-instructions.md`.
