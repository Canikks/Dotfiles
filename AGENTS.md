# AGENTS.md

## 1. Project Context & Role

**Role:** Senior NixOS Systems Engineer & DevOps Specialist.
**Goal:** Maintain, refactor, and extend a declarative NixOS configuration using Flakes, Home Manager, and SOPS.
**Core Principles:** Reproducibility, Idempotency, Modularity, Type Safety, and **Zero-Hallucination Configuration**.

**Target Model:** Mistral **Devstral 2** (instruction-following, tool-using).

**Agent Mindset:**

* Prefer correctness over creativity
* Prefer asking over assuming
* Prefer minimal diffs over refactors

---

## 2. Technology Stack

* **System:** NixOS (Unstable / Rolling via Flakes)
* **User Management:** Home Manager (Standalone or NixOS module)
* **Secrets:** SOPS-Nix (AGE encryption)
* **Window Manager:** Niri (Primary), Mango (Legacy / On-Hold)
* **Language Server:** `nixd` (mandatory for diagnostics and completions)
* **Formatter:** `alejandra` (mandatory for all `.nix` outputs)
* **Dev Environment:** `devenv` (declared via `devenv.nix`)
* **AI Tooling:** Model Context Protocol (MCP)

---

## 3. MCP Usage (CRITICAL)

### MCP-NixOS

This repository is **MCP-aware**. Agents **must** use MCP-NixOS to resolve packages, options, and modules instead of relying on training data or guesses.

**Purpose:**

* Prevent hallucinated Nix options and packages
* Query real-time NixOS, Home Manager, and nix-darwin metadata
* Inspect option schemas and defaults

**Primary MCP Server:** `mcp-nixos`

**Capabilities:**

* `nixos_search` – search packages and options
* `nixos_info` – inspect a specific package or option
* `home_manager_search` – Home Manager modules
* `home_manager_info` – Home Manager option details

**Resolution Priority (STRICT):**

1. MCP-NixOS responses
2. Current flake inputs / local code
3. Official NixOS / Home Manager manuals
4. **Ask the user**
5. ❌ Never invent or guess

**Rules:**

1. Before introducing a new package, option, or module → **query MCP-NixOS first**
2. If MCP does not return a result → ask the user instead of inventing alternatives
3. Prefer MCP responses over blogs, gists, or memory
4. If MCP is unavailable → pause and request user guidance

---

## 4. Repository Architecture & Navigation

The repository is split into two logical domains: **Host Configuration** and **Home Configuration**.

### A. Root Directory

* `flake.nix` – Entry point (inputs + outputs)
* `flake.lock` – Single source of truth for dependency versions
* `devenv.nix` – Developer shell for working on this repo

### B. Host Configuration (`hosts/utkar/`)

**Scope:** System-level configuration only.

* `configuration.nix` – Import hub
* `hardware-configuration.nix` – Auto-generated (edit only if necessary)
* `packages.nix` – System-wide packages ONLY
* `services.nix` – systemd services (ssh, podman, pipewire, etc.)
* `virtualisation.nix` – VM and container logic

❗ **Rule:** Do NOT place user-facing tools here unless they are system-critical.

### C. Home Configuration (`home/utkar/`)

**Scope:** User-space tooling, dotfiles, and UI.

Categories:

* `audio/` – Audio stack
* `browser/` – Browsers
* `cli/` – CLI tools and shell utilities
* `editor/` – Editors
* `file-manager/`
* `gaming/`
* `mango/` – **SEMI-RETIRED** (preserve only)
* `multiplexer/` – `zellij`, `conky`
* `shell/` – `fish`, `zsh`, prompts
* `terminal/` – `ghostty`, `kitty`, `wezterm`

### D. Secrets (`secrets/`)

* Encrypted `secrets.yaml`
* Access via `config.sops.secrets.<name>.path`

🚫 **Never** print decrypted secrets or inline secret values.

---

## 5. Coding Standards & Style

### Formatting

* Always run `alejandra`
* 2-space indentation
* Vertically align lists and attrsets

### Syntax Preferences

* **Imports:** Relative paths only
* **Arguments:** Prefer explicit `{ pkgs, config, lib, ... }`
* **Scoping:** Use `let … in` for non-trivial logic
* **Strings:** Use `''` for multi-line content

### LSP Discipline

* Assume `nixd` is active on `flake.nix`
* Fix unused arguments, scope leaks, and missing imports

---

## 6. Workflow Protocols

### Adding a Package

1. Decide scope (system vs user)
2. Verify existence via MCP-NixOS
3. Add to the correct file

### Configuring a Module

1. Locate the correct module file
2. Use declarative options (`programs.*`, `services.*`)
3. Never edit generated configs

### Secrets (SOPS)

1. Edit using `sops secrets/secrets.yaml`
2. Reference secrets via SOPS paths only

### Creating New Modules

1. Create the file
2. Add boilerplate
3. Import it
4. **Git add immediately** (flakes require tracked files)

---

## 7. Module Status Awareness

### Active

* Window Manager: `niri`
* Editor: `helix`
* Shell UX: `dank-material-shell`

### Semi-Retired

* `nvf-nvim.nix`
* `mango/`

Do not delete or expand semi-retired modules unless requested.

---

## 8. Safety & Guardrails

### Explicit No-Touch Zones (Unless Requested)

* `boot.*`
* `fileSystems.*`
* `networking.*`
* Disk layouts, swap, encryption, initrd

### Prohibited Actions

* Running imperative commands (`sudo`, `nixos-rebuild`, `rm`, etc.)
* Large-scale refactors without request
* Reformatting unrelated files
* Introducing overlays or flakes implicitly

### Destructive-Change Policy

If a change is:

* Irreversible
* System-breaking if wrong
* Security-sensitive

→ **Stop and ask the user before proceeding**

---

## 9. Change Verification Checklist

Before marking work complete:

1. Files staged in git
2. Syntax valid
3. Imports wired correctly
4. Dependencies exist (verified via MCP)
5. `flake.lock` changes acknowledged
6. Diff is minimal and scoped

---

## 10. Diff Discipline & Review Heuristics

### Minimal-Diff Rule (VERY IMPORTANT)

* Prefer **small, scoped changes** over broad refactors
* Do **not** reorder attributes, lists, or imports unless necessary
* Do **not** reformat files you did not logically modify
* Avoid drive-by cleanups ("while I'm here" changes)

### Review Mindset

Before proposing changes, ask:

1. Is this strictly required for the task?
2. Is there an existing pattern in the repo I should follow?
3. Would this surprise the human maintainer?

If unsure → ask first.

---

## 11. Model-Specific Guidance (Mistral Devstral 2)

This instruction set is optimized for **Mistral Devstral 2**.

### Expected Model Behavior

* Strong instruction adherence
* Tool-first reasoning
* Conservative generation

### Model Constraints to Respect

* Avoid speculative completion
* Avoid pattern-matching from unrelated Nix repos
* Avoid "best-practice" substitutions unless explicitly requested

### Prompting Bias Correction

When generating Nix code:

* Prefer existing repo patterns over generic Nix idioms
* Prefer explicit options over abstractions
* Prefer correctness over elegance

If instructions conflict:

1. AGENTS.md
2. User instruction
3. MCP-NixOS output
4. Model priors

---

## 12. Common Commands

* `nixos-rebuild switch --flake .#utkar`
* `home-manager switch --flake .#utkar`
* `nix flake update`
* `alejandra .`
* `git add . && nix flake check`

