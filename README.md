# 🛠️ macOS development setup script and disk structure

This repository contains a recommended initial setup guide for development environments on macOS, including:

* Installation of key tools
* File system organization
* Synology NAS synchronization
* Backup and security recommendations

---

## 📁 Recommended folder structure

```bash
~/Personal            # Personal data: photos, documents, health, etc.
~/Work                # Professional projects (clients, Corbat, invoicing...)
~/Repos               # Source code (split into personal and professional)
~/Sync/SynoDocs       # Synced with NAS for working documents
~/Sync/SynoPro        # Another NAS-synced folder (large projects, backups)
~/Downloads           # Temporary downloads
~/Desktop             # Only temporary files or immediate use
~/tmp                 # Experiments, tests, non-persistent data
```

You can create this structure by running:

```bash
mkdir -p ~/Personal \
         ~/Work/{Clientes,Corbat,Freelance} \
         ~/Repos/{personales,profesionales} \
         ~/Sync/{SynoDocs,SynoPro} \
         ~/Downloads ~/Desktop ~/tmp
```

---

## 🔄 Synology NAS synchronization

Requires **Synology Drive Client**:

* 📅 [Descargar Synology Drive Client](https://www.synology.com/en-global/dsm/feature/drive)

### Two-way sync configuration:

| Mac               | NAS                 |
| ----------------- | ------------------- |
| `~/Sync/SynoDocs` | `/volume1/SynoDocs` |
| `~/Sync/SynoPro`  | `/volume1/SynoPro`  |

> ✅ **Enable file versioning in Synology** for recovery from mistakes.
> ⚠️ **Do not sync source code with Synology. Use Git for that.**

---

## 🔐 Backups and security

1. **Time Machine**

   * Recommended with an external drive or a NAS as destination.

2. **Weekly NAS backups**

   * To an external USB drive using **Hyper Backup**.

3. **Git repositories**

   * Store on GitHub, GitLab, or Bitbucket (private mode).

---

## ⚙️ Recommended configurations

* Use a `.gitignore_global` to exclude system files.
* Use **tags** in Finder to mark active folders.
* Add useful aliases in `~/.zshrc`:

```bash
alias repos="cd ~/Repos"
alias work="cd ~/Work"
alias syncdocs="cd ~/Sync/SynoDocs"
```

---

## 📦 Install main software with Homebrew

### Step 1: Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Install software

```bash
# GUI applications (brew cask)
brew install --cask \
  docker \
  google-chrome \
  iterm2 \
  postman \
  visual-studio-code \
  intellij-idea \
  dbeaver-community \
  notion \
  alt-tab \
  zoom \
  elgato-stream-deck \
  monitorcontrol

# CLI tools
brew install \
  git \
  kubectl \
  awscli \
  maven \
  gradle \
  kotlin \
  openjdk@21 \
  openjdk@17 \
  node \
  python \
  wget \
  unzip
```

### Step 3: Set default JDK

```bash
sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk.jdk
```

---

### 📦 Summary of installed packages

#### GUI Applications (Casks)
- **docker**: Container platform with GUI.
- **google-chrome**: Web browser by Google.
- **iterm2**: Advanced terminal with tabs and customization.
- **postman**: GUI client to test REST/GraphQL APIs.
- **visual-studio-code**: Lightweight code editor with extensions.
- **intellij-idea**: Professional IDE for Java/Kotlin/Spring.
- **cursor**: AI-powered IDE (VSCode fork).
- **dbeaver-community**: Universal database client.
- **notion**: Notes, wikis, and project management.
- **zoom**: Video conferencing.
- **monitorcontrol**: Control brightness/volume of external monitors.
- **slack**: Team communication.

#### CLI Tools
- **git**: Distributed version control.
- **kubectl**: CLI to manage Kubernetes.
- **awscli**: Official AWS CLI.
- **openjdk@21 / openjdk@17**: Java JDKs 21 and 17.
- **node**: JavaScript runtime for backend.
- **python**: Programming language and runtime.
- **wget**: HTTP/FTP file downloader.
- **unzip**: ZIP archive extractor.
- **jq**: JSON processor for terminal.
- **yq**: YAML processor for terminal.
- **httpie**: Modern HTTP client (curl alternative).
- **ripgrep**: Fast text search.
- **fd**: Modern file search.
- **fzf**: Interactive fuzzy finder.
- **tree**: Directory tree view.
- **tmux**: Terminal multiplexer.
- **direnv**: Per-directory environment variables.
- **pre-commit**: Git hooks framework.
- **gh**: GitHub CLI.
- **helm**: Package manager for Kubernetes.
- **k9s**: Terminal dashboard for Kubernetes.
- **kubectx**: Fast K8s context switching.
- **kubens**: Fast K8s namespace switching.
- **kind**: Local Kubernetes with Docker.
- **terraform**: Infrastructure as code.
- **terragrunt**: DRY wrapper for Terraform.
- **aws-vault**: Secure AWS credentials manager.
- **postgresql**: Relational database.
- **redis**: In-memory store for cache/queues.
- **ktlint**: Kotlin style linter.
- **detekt**: Static analysis for Kotlin.
- **protobuf**: Protocol Buffers compiler.
- **grpcurl**: gRPC command-line client.
- **buf**: Modern toolkit for Protocol Buffers.
- **k6**: API performance testing.
- **hey**: HTTP load generator.
- **mkcert**: Local trusted SSL certificates.
- **sops**: Encrypted secrets management in files.
- **age**: Modern file encryption.
- **dive**: Analyze Docker image layers.
- **pgcli**: PostgreSQL client with autocompletion.
- **graphviz**: Graph/diagram rendering.

#### SDKs via SDKMAN!
- **java 21-tem / 17-tem**: Temurin (Eclipse) JDKs versions 21 and 17.
- **maven**: Dependency manager and build tool for Java.
- **gradle**: Modern build tool for the JVM.
- **kotlin**: Language interoperable with Java.
- **springboot**: CLI for Spring Boot scaffolding/prototypes.
- **jbang**: Run Java scripts without a project.
- **micronaut**: Lightweight framework for microservices.
- **quarkus**: Java framework optimized for cloud/containers.

---

## 🧠 Other useful concepts

### A) Dotfiles and symlinks

You can keep your configuration files (like `.zshrc`, `.gitconfig`, etc.) versioned in Git:

```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

### B) Add SSH keys

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub  # Copy to add to GitHub
```

---

## 💡 Additional recommended software

| Category       | Applications               | Notes                                 |
| -------------- | -------------------------- | ------------------------------------- |
| Communication  | Slack, Discord, Zoom       |                                       |
| Productivity   | Notion, Raycast, Rectangle |                                       |
| Development    | Cursor (AI IDE), Warp      | Alternative to VSCode/Terminal        |
| Monitoring     | Stats, iStat Menus         | Temperature, memory, system usage     |
| Automation     | Raycast, Alfred            | Workflows and automation              |
| Audio          | VB-Audio, OBS, Krisp       | Filters and audio control             |
| Macros/Shortcuts | Elgato Stream Deck + app | Launchers, automations                |

---

## ✅ Final checklist for a ready environment

* [x] Create folder structure
* [x] Configure Synology synchronization
* [x] Install software with Homebrew
* [x] Add SSH keys
* [x] Configure dotfiles and aliases
* [x] Enable Time Machine and NAS backups

---

> *This README is part of the professional development environment maintained by [your name or company].*
> *Last updated: 2025-08-08*
