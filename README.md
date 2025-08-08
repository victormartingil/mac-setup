# 🛠️ macOS Development Setup Script (`install-dev-tools.sh`)

This repository provides a single automated script to set up a macOS development environment in a reproducible and idempotent way.

- Installs GUI applications (Homebrew Casks)
- Installs CLI tools (Homebrew)
- Sets up SDKMAN! and installs JVM-related SDKs
- Configures defaults (e.g., default JDK, SDKs)
- Creates a basic folder structure and adds useful shell aliases
- Installs and configures Oh My Zsh (if missing)
- Produces a detailed log with success and error counts

---

## ✅ What the script does

- Ensures Homebrew is present (installs it if missing)
- Installs GUI applications:
  - docker, google-chrome, iterm2, postman, visual-studio-code, intellij-idea, cursor,
    dbeaver-community, notion, zoom, monitorcontrol, slack
- Installs CLI tools:
  - git, kubectl, awscli, openjdk@21, openjdk@17, node, python, wget, unzip, jq, yq, httpie,
    ripgrep, fd, fzf, tree, tmux, direnv, pre-commit, gh, helm, k9s, minikube, kubectx, kubens,
    kind, terraform, terragrunt, aws-vault, postgresql, redis, ktlint, detekt, protobuf, grpcurl,
    buf, k6, hey, mkcert, sops, age, dive, pgcli, graphviz
- Sets up SDKMAN! (if missing) and installs SDK candidates:
  - java 21-tem, java 17-tem, maven, gradle, kotlin, springboot, jbang, micronaut, quarkus
- Configures defaults:
  - Sets Java 21-tem as the default SDKMAN! Java
  - Attempts to set maven, gradle, kotlin, and springboot as defaults
- Creates basic folders: `~/00-MyStuff`, `~/Work`
- Adds custom aliases to `~/.zshrc` (if marker is absent)
- Adds SDKMAN! initialization to `~/.zshrc` (if missing)
- Sets the system default JDK symlink to OpenJDK 21 (requires sudo)
- Installs Oh My Zsh if not present (without auto-opening a new shell)

---

## 🔁 Idempotency and behavior

- Homebrew packages and casks: skipped if already installed.
- SDKMAN! candidates:
  - With a specific version (e.g., `java 21-tem`): installs only if that exact version is not present.
  - Without a version (e.g., `maven`): if installed, tries to upgrade; if not installed, installs.
- Safe to re-run: only installs/upgrades what is missing or outdated.

---

## 📋 Requirements

- macOS with internet access.
- The script can install Homebrew automatically if not found.
- `sudo` privileges are required to set the system JDK symlink.

---

## ▶️ How to run

```bash
chmod +x install-dev-tools.sh
./install-dev-tools.sh
```

- The script runs non-interactively where possible, but may prompt for your `sudo` password to set the JDK symlink.
- After completion, restart your terminal to ensure shell changes are applied.

---

## 🧾 Logs and troubleshooting

- All output is logged to `./install-dev-tools.log`.
- At the end, the script prints totals for successes, errors, and already-installed items.
- Quick inspection examples:

```bash
# Tail the log live
tail -f install-dev-tools.log

# Show only errors
grep "❌ ERROR" install-dev-tools.log
```

---

## 🔧 What gets configured

- Folders:
  - `~/00-MyStuff`, `~/Work`
- Shell:
  - Adds a small set of custom aliases to `~/.zshrc` (only if a marker line is missing)
  - Adds SDKMAN! init line to `~/.zshrc` if not present
- Java:
  - Sets SDKMAN! default Java to `21-tem`
  - Creates a system-wide JDK symlink pointing to OpenJDK 21
- Oh My Zsh:
  - Installs if absent (does not auto-start a new shell on install)

---

## ❌ Uninstall (manual)

This script does not manage uninstallation. You can manually remove components, for example:

- Homebrew packages/casks: `brew uninstall <pkg>` / `brew uninstall --cask <cask>`
- SDKMAN! candidates: `sdk uninstall <candidate> [version]`
- Aliases and SDKMAN! init: edit `~/.zshrc`
- System JDK symlink: `sudo rm /Library/Java/JavaVirtualMachines/openjdk.jdk`

---

> Last updated: 2025-08-08
