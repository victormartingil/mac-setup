#!/bin/bash

### 🛠️ Automated installation script for a macOS development environment
### With robust logging and continue-on-error behavior

# Log file for errors and successes
LOG_FILE="$(pwd)/install-dev-tools.log"
echo "=== Instalación iniciada: $(date) ===" > "$LOG_FILE"

# Logging helpers
log_success() {
  echo "✅ $1" | tee -a "$LOG_FILE"
}

log_error() {
  echo "❌ ERROR: $1" | tee -a "$LOG_FILE"
}

log_info() {
  echo "ℹ️  $1" | tee -a "$LOG_FILE"
}

# Install a single cask
install_cask() {
  local cask="$1"
  if brew list --cask "$cask" &>/dev/null; then
    log_info "Cask '$cask' already installed"
    return 0
  fi
  
  if brew install --cask "$cask" &>/dev/null; then
    log_success "Cask '$cask' installed successfully"
    return 0
  else
    log_error "Failed to install cask '$cask'"
    return 1
  fi
}

# Install a single CLI package
install_brew() {
  local package="$1"
  if brew list "$package" &>/dev/null; then
    log_info "Package '$package' already installed"
    return 0
  fi
  
  if brew install "$package" &>/dev/null; then
    log_success "Package '$package' installed successfully"
    return 0
  else
    log_error "Failed to install package '$package'"
    return 1
  fi
}

# Requirements: Homebrew must be installed. If not present, it will be installed automatically.

if ! command -v brew &> /dev/null; then
  log_info "Homebrew not found. Installing Homebrew..."
  if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    log_success "Homebrew installed successfully"
  else
    log_error "Failed to install Homebrew"
  fi
else
  log_success "Homebrew already installed"
fi

# Install GUI software (single casks)
log_info "=== Starting GUI applications installation ==="
casks=(
  "docker"
  "google-chrome"
  "iterm2"
  "postman"
  "visual-studio-code"
  "intellij-idea"
  "cursor"
  "dbeaver-community"
  "notion"
  "zoom"
  "monitorcontrol"
  "slack"
)

for cask in "${casks[@]}"; do
  install_cask "$cask"
done


# Install CLI tools (individually)
log_info "=== Starting CLI tools installation ==="
cli_tools=(
  "git"
  "kubectl"
  "awscli"
  "openjdk@21"
  "openjdk@17"
  "node"
  "python"
  "wget"
  "unzip"
  "jq"
  "yq"
  "httpie"
  "ripgrep"
  "fd"
  "fzf"
  "tree"
  "tmux"
  "direnv"
  "pre-commit"
  "gh"
  "helm"
  "k9s"
  "minikube"
  "kubectx"
  "kubens"
  "kind"
  "terraform"
  "terragrunt"
  "aws-vault"
  "postgresql"
  "redis"
  "ktlint"
  "detekt"
  "protobuf"
  "grpcurl"
  "buf"
  "k6"
  "hey"
  "mkcert"
  "sops"
  "age"
  "dive"
  "pgcli"
  "graphviz"
)

for tool in "${cli_tools[@]}"; do
  install_brew "$tool"
done

# Create folder structure
log_info "=== Creating folder structure ==="
if mkdir -p ~/00-MyStuff ~/Work; then
  log_success "Folder structure created"
else
  log_error "Failed to create folder structure"
fi

# Configure useful aliases (fixes and additions)
log_info "=== Configuring aliases in .zshrc ==="
if ! grep -q "# Alias personalizados" ~/.zshrc 2>/dev/null; then
  {
    echo "";
    echo "# Custom aliases";
    echo "alias rep="cd ~/Work/_CORBAT/01-Repositories"
    echo "alias adv="cd ~/Work/_ADEVINTA/01-Repositories"
  } >> ~/.zshrc
  log_success "Aliases added to .zshrc"
else
  log_info "Aliases already configured in .zshrc"
fi

# SDKMAN!: install and key SDKs for Java/Kotlin/Spring Boot
log_info "=== Setting up SDKMAN! ==="
export SDKMAN_DIR="$HOME/.sdkman"
export SDKMAN_NON_INTERACTIVE=true

if [ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  log_info "Installing SDKMAN!..."
  if curl -s "https://get.sdkman.io" | bash; then
    log_success "SDKMAN! installed successfully"
  else
    log_error "SDKMAN! installation failed"
  fi
else
  log_info "SDKMAN! already installed"
fi

# Helper to install a single SDK candidate
install_sdk() {
  local candidate="$1"
  local version="${2:-}"
  
  if ! command -v sdk >/dev/null 2>&1; then
    log_error "SDKMAN! not available in this session"
    return 1
  fi

  if [ -n "$version" ]; then
    local full_name="$candidate $version"
    # Is the exact version already installed?
    if sdk list "$candidate" 2>/dev/null | grep -E "\\b$version\\b" | grep -q "installed"; then
      log_info "SDK '$full_name' already installed"
      return 0
    fi
    # Install specific version
    if echo "yes" | sdk install "$candidate" "$version" &>/dev/null; then
      log_success "SDK '$full_name' installed successfully"
      return 0
    else
      log_error "Failed to install SDK '$full_name'"
      return 1
    fi
  else
    # No version: if any is installed, try to upgrade; otherwise, install
    if sdk list "$candidate" 2>/dev/null | grep -q "installed" || sdk current "$candidate" >/dev/null 2>&1; then
      # Upgrade if updates are available (does not fail if already up to date)
      if echo "y" | sdk upgrade "$candidate" &>/dev/null; then
        log_success "SDK '$candidate' upgraded or already up to date"
      else
        log_info "SDK '$candidate' already up to date"
      fi
      return 0
    fi
    if echo "yes" | sdk install "$candidate" &>/dev/null; then
      log_success "SDK '$candidate' installed successfully"
      return 0
    else
      log_error "Failed to install SDK '$candidate'"
      return 1
    fi
  fi
}

# Load SDKMAN! environment and proceed with installs/upgrades
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  # shellcheck disable=SC1091
  source "$SDKMAN_DIR/bin/sdkman-init.sh"

  # Ensure initialization on future shells
  if ! grep -q "sdkman-init.sh" "$HOME/.zshrc" 2>/dev/null; then
    echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> "$HOME/.zshrc"
    log_success "SDKMAN! added to .zshrc"
  fi

  log_info "=== Installing/Upgrading SDKs with SDKMAN! ==="
  # JDKs (Temurin) for enterprise projects
  install_sdk "java" "21-tem"
  install_sdk "java" "17-tem"
  install_sdk "maven"
  install_sdk "gradle"
  install_sdk "kotlin"
  install_sdk "springboot"
  install_sdk "jbang"
  install_sdk "micronaut"
  install_sdk "quarkus"

  # Configure defaults (only if installed)
  log_info "=== Configuring default SDKs ==="
  sdk default java 21-tem &>/dev/null && log_success "Java 21-tem set as default" || log_error "Failed to set Java 21-tem as default"
  sdk default maven &>/dev/null && log_success "Maven set as default" || log_info "Maven default not set"
  sdk default gradle &>/dev/null && log_success "Gradle set as default" || log_info "Gradle default not set"
  sdk default kotlin &>/dev/null && log_success "Kotlin set as default" || log_info "Kotlin default not set"
  sdk default springboot &>/dev/null && log_success "Spring Boot CLI set as default" || log_info "Spring Boot CLI default not set"
else
  log_error "sdkman-init.sh not found"
fi

# Configure system default JDK
log_info "=== Configuring system default JDK ==="
if sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk 2>/dev/null; then
  log_success "JDK 21 configured as system default"
else
  log_error "Failed to set system default JDK"
fi

# Oh My Zsh: framework to enhance zsh
log_info "=== Setting up Oh My Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log_info "Installing Oh My Zsh..."
  if RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null; then
    log_success "Oh My Zsh installed successfully"
  else
    log_error "Failed to install Oh My Zsh"
  fi
else
  log_success "Oh My Zsh already installed"
fi

# Final installation report
log_info "=== FINAL INSTALLATION REPORT ==="
echo "=== FINAL REPORT: $(date) ===" >> "$LOG_FILE"

# Count successes and errors
success_count=$(grep -c "✅" "$LOG_FILE" || echo "0")
error_count=$(grep -c "❌ ERROR" "$LOG_FILE" || echo "0")
info_count=$(grep -c "ℹ️" "$LOG_FILE" || echo "0")

log_info "Total successful operations: $success_count"
log_info "Total errors: $error_count"
log_info "Total items already installed/configured: $info_count"

if [ "$error_count" -gt 0 ]; then
  echo ""
  log_error "$error_count errors found during installation"
  echo "Check the log file: $LOG_FILE"
  echo ""
  echo "❌ ERRORS FOUND:"
  grep "❌ ERROR" "$LOG_FILE" | sed 's/.*ERROR: /  - /'
else
  log_success "Installation completed without errors"
fi

echo ""
log_success "Installation and basic configuration completed"
log_info "Full log saved at: $LOG_FILE"
log_info "Restart your terminal to apply changes"
