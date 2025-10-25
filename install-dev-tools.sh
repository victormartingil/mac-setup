#!/bin/bash

### 🛠️ Automated installation script for a macOS development environment
### With robust logging and continue-on-error behavior

# Parse command line arguments
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 DRY RUN MODE - No installations will be performed"
  echo ""
fi

# Log file for errors and successes
LOG_FILE="$(pwd)/install-dev-tools.log"
echo "=== Instalación iniciada: $(date) ===" > "$LOG_FILE"

# Dry run mode indicator
if [ "$DRY_RUN" = true ]; then
  echo "=== DRY RUN MODE ===" >> "$LOG_FILE"
fi

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

  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would install cask '$cask'"
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

  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would install package '$package'"
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

# Warn about sudo requirement upfront
echo ""
echo "⚠️  IMPORTANT: This script will require sudo password for:"
echo "   - Setting system default JDK"
echo "   - Potentially during Homebrew installation"
echo ""
if [ "$DRY_RUN" = false ]; then
  read -p "Press Enter to continue or Ctrl+C to cancel..."
  echo ""
fi

if ! command -v brew &> /dev/null; then
  log_info "Homebrew not found. Installing Homebrew..."
  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would install Homebrew"
  else
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      log_success "Homebrew installed successfully"
      # Fix PATH for Apple Silicon Macs (critical fix)
      if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi
    else
      log_error "Failed to install Homebrew"
      exit 1
    fi
  fi
else
  log_success "Homebrew already installed"
fi

# Install gum for interactive selection (if not present)
if ! command -v gum &> /dev/null; then
  log_info "Installing gum for interactive tool selection..."
  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would install gum"
  else
    if brew install gum &>/dev/null; then
      log_success "gum installed successfully"
    else
      log_error "Failed to install gum"
      exit 1
    fi
  fi
else
  log_info "gum already installed"
fi

# Interactive selection of GUI applications
log_info "=== Select GUI applications to install ==="
all_casks=(
  "docker"
  "google-chrome"
  "iterm2"
  "postman"
  "bruno"
  "visual-studio-code"
  "intellij-idea"
  "cursor"
  "dbeaver-community"
  "notion"
  "monitorcontrol"
  "slack"
  "alt-tab"
  "lightshot"
  "maccy"
  "lazydocker"
)

# Use gum to select casks (all selected by default except cursor which is optional)
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would show GUI app selector"
  selected_casks=$(printf "%s\n" "${all_casks[@]}")
else
  selected_casks=$(gum choose --no-limit \
    --header "Select GUI applications to install (Space to toggle, Enter to confirm)" \
    --selected="docker,google-chrome,iterm2,postman,bruno,visual-studio-code,intellij-idea,dbeaver-community,notion,monitorcontrol,slack,alt-tab,lightshot,maccy,lazydocker" \
    "${all_casks[@]}")
fi

# Validate selection
if [ -z "$selected_casks" ]; then
  log_info "No GUI applications selected, skipping..."
else
  # Convert to array
  IFS=$'\n' read -r -d '' -a casks_array <<< "$selected_casks"

  log_info "=== Installing selected GUI applications ==="
  for cask in "${casks_array[@]}"; do
    install_cask "$cask"
  done
fi


# Interactive selection of CLI tools
log_info "=== Select CLI tools to install ==="
all_cli_tools=(
  "git"
  "gh"
  "kubectl"
  "stern"
  "awscli"
  "openjdk@25"
  "openjdk@21"
  "openjdk@17"
  "node"
  "python"
  "fnm"
  "pyenv"
  "wget"
  "unzip"
  "jq"
  "yq"
  "httpie"
  "ripgrep"
  "bat"
  "eza"
  "fd"
  "fzf"
  "tree"
  "tmux"
  "direnv"
  "helm"
  "k9s"
  "minikube"
  "kubectx"
  "kubens"
  "terraform"
  "aws-vault"
  "ktlint"
  "detekt"
  "protobuf"
  "grpcurl"
  "k6"
  "mkcert"
  "sops"
  "dive"
  "pgcli"
  "htop"
  "watch"
)

# Use gum to select CLI tools (all selected by default)
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would show CLI tools selector"
  selected_cli_tools=$(printf "%s\n" "${all_cli_tools[@]}")
else
  selected_cli_tools=$(gum choose --no-limit \
    --header "Select CLI tools to install (Space to toggle, Enter to confirm)" \
    --height 20 \
    --selected="git,gh,kubectl,stern,awscli,openjdk@25,openjdk@21,openjdk@17,node,python,fnm,pyenv,wget,unzip,jq,yq,httpie,ripgrep,bat,eza,fd,fzf,tree,tmux,direnv,helm,k9s,minikube,kubectx,kubens,terraform,aws-vault,ktlint,detekt,protobuf,grpcurl,k6,mkcert,sops,dive,pgcli,htop,watch" \
    "${all_cli_tools[@]}")
fi

# Validate selection
if [ -z "$selected_cli_tools" ]; then
  log_info "No CLI tools selected, skipping..."
else
  # Convert to array
  IFS=$'\n' read -r -d '' -a cli_tools_array <<< "$selected_cli_tools"

  log_info "=== Installing selected CLI tools ==="
  for tool in "${cli_tools_array[@]}"; do
    install_brew "$tool"
  done
fi

# Create folder structure
log_info "=== Creating folder structure ==="
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would create ~/00-MyStuff and ~/Work"
else
  if mkdir -p ~/00-MyStuff ~/Work; then
    log_success "Folder structure created"
  else
    log_error "Failed to create folder structure"
  fi
fi

# Configure useful aliases (fixes and additions)
log_info "=== Configuring aliases in .zshrc ==="
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would configure aliases in .zshrc"
else
  if ! grep -q "# Custom aliases" ~/.zshrc 2>/dev/null; then
    {
      echo "";
      echo "# Custom aliases";
      echo "alias rep='cd ~/Work/_CORBAT/01-Repositories'";
      echo "alias adv='cd ~/Work/_ADEVINTA/01-Repositories'";
    } >> ~/.zshrc
    log_success "Aliases added to .zshrc"
  else
    log_info "Aliases already configured in .zshrc"
  fi
fi

# SDKMAN!: install and key SDKs for Java/Kotlin/Spring Boot
log_info "=== Setting up SDKMAN! ==="
export SDKMAN_DIR="$HOME/.sdkman"
export SDKMAN_NON_INTERACTIVE=true

if [ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  log_info "Installing SDKMAN!..."
  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would install SDKMAN!"
  else
    if curl -s "https://get.sdkman.io" | bash; then
      log_success "SDKMAN! installed successfully"
    else
      log_error "SDKMAN! installation failed"
    fi
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

  if [ "$DRY_RUN" = true ]; then
    if [ -n "$version" ]; then
      log_info "[DRY RUN] Would install SDK '$candidate $version'"
    else
      log_info "[DRY RUN] Would install SDK '$candidate'"
    fi
    return 0
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

  # Interactive selection of SDKMAN! candidates
  log_info "=== Select JVM SDKs to install ==="
  all_sdks=(
    "java-25-tem"
    "java-21-tem"
    "java-17-tem"
    "maven"
    "gradle"
    "kotlin"
    "springboot"
    "jbang"
  )

  # Use gum to select SDKs (all selected by default)
  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would show JVM SDKs selector"
    selected_sdks=$(printf "%s\n" "${all_sdks[@]}")
  else
    selected_sdks=$(gum choose --no-limit \
      --header "Select JVM SDKs to install via SDKMAN! (Space to toggle, Enter to confirm)" \
      --selected="java-25-tem,java-21-tem,java-17-tem,maven,gradle,kotlin,springboot,jbang" \
      "${all_sdks[@]}")
  fi

  # Validate selection
  if [ -z "$selected_sdks" ]; then
    log_info "No JVM SDKs selected, skipping..."
  else
    # Convert to array
    IFS=$'\n' read -r -d '' -a sdks_array <<< "$selected_sdks"

    log_info "=== Installing/Upgrading selected SDKs with SDKMAN! ==="
    for sdk in "${sdks_array[@]}"; do
      # Parse SDK name and version
      if [[ "$sdk" == java-* ]]; then
        version="${sdk#java-}"  # Remove "java-" prefix
        install_sdk "java" "$version"
      else
        install_sdk "$sdk"
      fi
    done
  fi

  # Configure defaults (only if installed)
  if [ "$DRY_RUN" = true ]; then
    log_info "[DRY RUN] Would configure default SDKs"
  else
    log_info "=== Configuring default SDKs ==="
    sdk default java 25-tem &>/dev/null && log_success "Java 25-tem set as default" || log_error "Failed to set Java 25-tem as default"
    sdk default maven &>/dev/null && log_success "Maven set as default" || log_info "Maven default not set"
    sdk default gradle &>/dev/null && log_success "Gradle set as default" || log_info "Gradle default not set"
    sdk default kotlin &>/dev/null && log_success "Kotlin set as default" || log_info "Kotlin default not set"
    sdk default springboot &>/dev/null && log_success "Spring Boot CLI set as default" || log_info "Spring Boot CLI default not set"
  fi
else
  log_error "sdkman-init.sh not found"
fi

# Configure system default JDK
log_info "=== Configuring system default JDK ==="
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would configure JDK 25 as system default"
else
  if sudo ln -sfn /opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk 2>/dev/null; then
    log_success "JDK 25 configured as system default"
  else
    log_error "Failed to set system default JDK"
  fi
fi

# Oh My Zsh: framework to enhance zsh
log_info "=== Setting up Oh My Zsh ==="
if [ "$DRY_RUN" = true ]; then
  log_info "[DRY RUN] Would install Oh My Zsh"
else
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
fi

# Final installation report
log_info "=== FINAL INSTALLATION REPORT ==="
echo "=== FINAL REPORT: $(date) ===" >> "$LOG_FILE"

# Count successes and errors (grep -c always returns a number, even if 0)
success_count=$(grep -c "✅" "$LOG_FILE" 2>/dev/null) || success_count=0
error_count=$(grep -c "❌ ERROR" "$LOG_FILE" 2>/dev/null) || error_count=0
info_count=$(grep -c "ℹ️" "$LOG_FILE" 2>/dev/null) || info_count=0

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
