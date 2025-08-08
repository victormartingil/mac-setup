#!/bin/bash

### 🛠️ Script de instalación automática para entorno de desarrollo en macOS
### Con logging robusto y continuación ante fallos

# Archivo de log para errores y éxitos
LOG_FILE="$(pwd)/install-dev-tools.log"
echo "=== Instalación iniciada: $(date) ===" > "$LOG_FILE"

# Funciones de logging
log_success() {
  echo "✅ $1" | tee -a "$LOG_FILE"
}

log_error() {
  echo "❌ ERROR: $1" | tee -a "$LOG_FILE"
}

log_info() {
  echo "ℹ️  $1" | tee -a "$LOG_FILE"
}

# Función para instalar cask individual
install_cask() {
  local cask="$1"
  if brew list --cask "$cask" &>/dev/null; then
    log_info "Cask '$cask' ya está instalado"
    return 0
  fi
  
  if brew install --cask "$cask" &>/dev/null; then
    log_success "Cask '$cask' instalado correctamente"
    return 0
  else
    log_error "Falló instalación del cask '$cask'"
    return 1
  fi
}

# Función para instalar paquete CLI individual
install_brew() {
  local package="$1"
  if brew list "$package" &>/dev/null; then
    log_info "Paquete '$package' ya está instalado"
    return 0
  fi
  
  if brew install "$package" &>/dev/null; then
    log_success "Paquete '$package' instalado correctamente"
    return 0
  else
    log_error "Falló instalación del paquete '$package'"
    return 1
  fi
}

# Requisitos: Homebrew debe estar instalado. Si no lo está, se instalará automáticamente.

if ! command -v brew &> /dev/null; then
  log_info "Homebrew no encontrado. Instalando Homebrew..."
  if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    log_success "Homebrew instalado correctamente"
  else
    log_error "Falló la instalación de Homebrew"
  fi
else
  log_success "Homebrew ya está instalado"
fi

# Instalación de software gráfico (casks individuales)
log_info "=== Iniciando instalación de aplicaciones GUI ==="
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


# Instalación de herramientas CLI (individuales)
log_info "=== Iniciando instalación de herramientas CLI ==="
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

# Crear estructura de carpetas
log_info "=== Creando estructura de carpetas ==="
if mkdir -p ~/00-MyStuff ~/01-Work; then
  log_success "Estructura de carpetas creada"
else
  log_error "Falló la creación de estructura de carpetas"
fi

# Configurar alias útiles (correcciones y añadidos)
log_info "=== Configurando aliases en .zshrc ==="
if ! grep -q "# Alias personalizados" ~/.zshrc 2>/dev/null; then
  {
    echo "";
    echo "# Alias personalizados";
    echo "alias rep=\"cd ~/Work/_CORBAT/01-Repositories\"";
    echo "alias adv=\"cd ~/Work/_ADEVINTA/01-Repositories\"";
  } >> ~/.zshrc
  log_success "Aliases añadidos a .zshrc"
else
  log_info "Aliases ya están configurados en .zshrc"
fi

# SDKMAN!: instalación y SDKs clave para Java/Kotlin/Spring Boot
log_info "=== Configurando SDKMAN! ==="
if ! command -v sdk >/dev/null 2>&1 && [ ! -d "$HOME/.sdkman" ]; then
  log_info "Instalando SDKMAN!..."
  export SDKMAN_DIR="$HOME/.sdkman"
  export SDKMAN_NON_INTERACTIVE=true
  if curl -s "https://get.sdkman.io" | bash; then
    log_success "SDKMAN! instalado correctamente"
  else
    log_error "Falló la instalación de SDKMAN!"
  fi
else
  log_info "SDKMAN! ya está instalado"
fi

# Función para instalar candidato SDK individual
install_sdk() {
  local candidate="$1"
  local version="${2:-}"
  
  if [ -n "$version" ]; then
    local full_name="$candidate $version"
    if sdk list "$candidate" 2>/dev/null | grep -q "$version.*installed" 2>/dev/null; then
      log_info "SDK '$full_name' ya está instalado"
      return 0
    fi
    
    if echo "yes" | sdk install "$candidate" "$version" &>/dev/null; then
      log_success "SDK '$full_name' instalado correctamente"
      return 0
    else
      log_error "Falló instalación de SDK '$full_name'"
      return 1
    fi
  else
    if sdk list "$candidate" 2>/dev/null | grep -q "installed" 2>/dev/null; then
      log_info "SDK '$candidate' ya está instalado"
      return 0
    fi
    
    if echo "yes" | sdk install "$candidate" &>/dev/null; then
      log_success "SDK '$candidate' instalado correctamente"
      return 0
    else
      log_error "Falló instalación de SDK '$candidate'"
      return 1
    fi
  fi
}

# Inicializar SDKMAN! en esta sesión y añadir a ~/.zshrc si falta
if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  if ! grep -q "sdkman-init.sh" "$HOME/.zshrc"; then
    echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> "$HOME/.zshrc"
    log_success "SDKMAN! añadido a .zshrc"
  fi

  log_info "=== Instalando SDKs con SDKMAN! ==="
  # JDKs (Temurin) para proyectos enterprise
  install_sdk "java" "21-tem"
  install_sdk "java" "17-tem"
  install_sdk "maven"
  install_sdk "gradle"
  install_sdk "kotlin"
  install_sdk "springboot"
  install_sdk "jbang"
  install_sdk "micronaut"
  install_sdk "quarkus"

  # Configurar defaults (solo si se instalaron)
  log_info "=== Configurando SDKs por defecto ==="
  sdk default java 21-tem &>/dev/null && log_success "Java 21-tem configurado como default" || log_error "Falló configurar Java 21-tem como default"
  sdk default maven &>/dev/null && log_success "Maven configurado como default" || log_info "Maven default no configurado"
  sdk default gradle &>/dev/null && log_success "Gradle configurado como default" || log_info "Gradle default no configurado"
  sdk default kotlin &>/dev/null && log_success "Kotlin configurado como default" || log_info "Kotlin default no configurado"
  sdk default springboot &>/dev/null && log_success "Spring Boot CLI configurado como default" || log_info "Spring Boot CLI default no configurado"
fi

# Configurar JDK por defecto
log_info "=== Configurando JDK por defecto del sistema ==="
if sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk 2>/dev/null; then
  log_success "JDK 21 configurado como default del sistema"
else
  log_error "Falló la configuración del JDK por defecto del sistema"
fi

# Oh My Zsh: framework para mejorar zsh
log_info "=== Configurando Oh My Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log_info "Instalando Oh My Zsh..."
  if RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null; then
    log_success "Oh My Zsh instalado correctamente"
  else
    log_error "Falló la instalación de Oh My Zsh"
  fi
else
  log_success "Oh My Zsh ya está instalado"
fi

# Reporte final de instalación
log_info "=== REPORTE FINAL DE INSTALACIÓN ==="
echo "=== REPORTE FINAL: $(date) ===" >> "$LOG_FILE"

# Contar éxitos y errores
success_count=$(grep -c "✅" "$LOG_FILE" || echo "0")
error_count=$(grep -c "❌ ERROR" "$LOG_FILE" || echo "0")
info_count=$(grep -c "ℹ️" "$LOG_FILE" || echo "0")

log_info "Total de operaciones exitosas: $success_count"
log_info "Total de errores: $error_count"
log_info "Total de elementos ya instalados/configurados: $info_count"

if [ "$error_count" -gt 0 ]; then
  echo ""
  log_error "Se encontraron $error_count errores durante la instalación"
  echo "Revisa el archivo de log: $LOG_FILE"
  echo ""
  echo "❌ ERRORES ENCONTRADOS:"
  grep "❌ ERROR" "$LOG_FILE" | sed 's/.*ERROR: /  - /'
else
  log_success "Instalación completada sin errores"
fi

echo ""
log_success "Instalación y configuración básica completadas"
log_info "Log completo guardado en: $LOG_FILE"
log_info "Reinicia la terminal para aplicar los cambios"
