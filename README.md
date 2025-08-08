# 🛠️ Script de configuración y estructura de disco para desarrollo en Mac

Este repositorio contiene una guía de configuración inicial recomendada para entornos de desarrollo en Mac, incluyendo:

* Instalación de herramientas clave
* Organización del sistema de archivos
* Sincronización con NAS Synology
* Recomendaciones de backup y seguridad

---

## 📁 Estructura de carpetas recomendada

```bash
~/Personal            # Datos personales: fotos, documentos, salud, etc.
~/Work                # Proyectos profesionales (clientes, Corbat, facturación...)
~/Repos               # Código fuente (subdividido por personales y profesionales)
~/Sync/SynoDocs       # Carpeta sincronizada con NAS para documentos de trabajo
~/Sync/SynoPro        # Otra carpeta sincronizada con NAS (proyectos grandes, backups)
~/Downloads           # Descargas temporales
~/Desktop             # Solo archivos temporales o de uso inmediato
~/tmp                 # Experimentos, pruebas, datos no persistentes
```

Puedes crear esta estructura ejecutando:

```bash
mkdir -p ~/Personal \
         ~/Work/{Clientes,Corbat,Freelance} \
         ~/Repos/{personales,profesionales} \
         ~/Sync/{SynoDocs,SynoPro} \
         ~/Downloads ~/Desktop ~/tmp
```

---

## 🔄 Sincronización con NAS Synology

Requiere **Synology Drive Client**:

* 📅 [Descargar Synology Drive Client](https://www.synology.com/en-global/dsm/feature/drive)

### Configuración bidireccional:

| Mac               | NAS                 |
| ----------------- | ------------------- |
| `~/Sync/SynoDocs` | `/volume1/SynoDocs` |
| `~/Sync/SynoPro`  | `/volume1/SynoPro`  |

> ✅ **Activa la versión de archivos en Synology** para recuperación ante errores.
> ⚠️ **No sincronices código fuente con Synology. Usa Git para eso.**

---

## 🔐 Backups y seguridad

1. **Time Machine**

   * Recomendado con disco externo o NAS como destino.

2. **Backups semanales del NAS**

   * A disco externo USB usando **Hyper Backup**.

3. **Repositorios Git**

   * Almacena en GitHub, GitLab o Bitbucket (modo privado).

---

## ⚙️ Configuraciones recomendadas

* Usar un `.gitignore_global` para excluir archivos del sistema.
* Utilizar **etiquetas** en Finder para marcar carpetas activas.
* Añadir alias útiles en `~/.zshrc`:

```bash
alias repos="cd ~/Repos"
alias work="cd ~/Work"
alias syncdocs="cd ~/Sync/SynoDocs"
```

---

## 📦 Instalar software principal con Homebrew

### Paso 1: Instalar Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Paso 2: Instalar software

```bash
# Aplicaciones GUI (brew cask)
brew install --cask \
  docker \
  google-chrome \
  iterm2 \
  postman \
  visual-studio-code \
  intellij-idea \
  dbeaver-community \
  notion \
  zoom \
  elgato-stream-deck \
  monitorcontrol

# Herramientas CLI
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

### Paso 3: Establecer JDK por defecto

```bash
sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk.jdk
```

---

### 📦 Resumen de paquetes instalados

#### Aplicaciones GUI (Casks)
- **docker**: Plataforma de contenedores con interfaz gráfica.
- **google-chrome**: Navegador web de Google.
- **iterm2**: Terminal avanzada con pestañas y personalización.
- **postman**: Cliente GUI para probar APIs REST/GraphQL.
- **visual-studio-code**: Editor de código ligero con extensiones.
- **intellij-idea**: IDE profesional para Java/Kotlin/Spring.
- **cursor**: IDE con IA integrada (fork de VSCode).
- **dbeaver-community**: Cliente universal de bases de datos.
- **notion**: Notas, wikis y gestión de proyectos.
- **zoom**: Videoconferencias.
- **monitorcontrol**: Controla brillo/volumen de monitores externos.
- **slack**: Comunicación empresarial.

#### Herramientas CLI
- **git**: Control de versiones distribuido.
- **kubectl**: CLI para gestionar Kubernetes.
- **awscli**: CLI oficial de AWS.
- **openjdk@21 / openjdk@17**: JDKs de Java 21 y 17.
- **node**: Runtime de JavaScript para backend.
- **python**: Lenguaje de programación y runtime.
- **wget**: Descarga de archivos por HTTP/FTP.
- **unzip**: Extractor de archivos ZIP.
- **jq**: Procesador de JSON en terminal.
- **yq**: Procesador de YAML en terminal.
- **httpie**: Cliente HTTP moderno (alternativa a curl).
- **ripgrep**: Búsqueda de texto rápida.
- **fd**: Búsqueda de archivos moderna.
- **fzf**: Búsqueda difusa interactiva.
- **tree**: Vista de directorios en árbol.
- **tmux**: Multiplexor de terminal.
- **direnv**: Variables de entorno por directorio.
- **pre-commit**: Framework de hooks para Git.
- **gh**: CLI de GitHub.
- **helm**: Gestor de paquetes para Kubernetes.
- **k9s**: Dashboard de Kubernetes en terminal.
- **kubectx**: Cambio rápido de contextos de K8s.
- **kubens**: Cambio rápido de namespaces de K8s.
- **kind**: Kubernetes local con Docker.
- **terraform**: Infraestructura como código.
- **terragrunt**: Wrapper DRY para Terraform.
- **aws-vault**: Gestor seguro de credenciales AWS.
- **postgresql**: Base de datos relacional.
- **redis**: Almacén en memoria para cache/colas.
- **ktlint**: Linter de estilo para Kotlin.
- **detekt**: Análisis estático para Kotlin.
- **protobuf**: Compilador de Protocol Buffers.
- **grpcurl**: Cliente gRPC de línea de comandos.
- **buf**: Toolkit moderno para Protocol Buffers.
- **k6**: Testing de performance para APIs.
- **hey**: Generador de carga HTTP.
- **mkcert**: Certificados SSL locales de confianza.
- **sops**: Gestión de secretos cifrados en archivos.
- **age**: Cifrado moderno de archivos.
- **dive**: Analiza capas de imágenes Docker.
- **pgcli**: Cliente PostgreSQL con autocompletado.
- **graphviz**: Renderizado de gráficos/diagramas.

#### SDKs vía SDKMAN!
- **java 21-tem / 17-tem**: JDKs Temurin (Eclipse) versiones 21 y 17.
- **maven**: Gestor de dependencias y build para Java.
- **gradle**: Build tool moderno para JVM.
- **kotlin**: Lenguaje interoperable con Java.
- **springboot**: CLI para scaffolding/prototipos Spring Boot.
- **jbang**: Ejecuta scripts Java sin proyecto.
- **micronaut**: Framework ligero para microservicios.
- **quarkus**: Framework Java optimizado para cloud/containers.

---

## 🧠 Otros conceptos útiles

### A) Dotfiles y symlinks

Puedes mantener tus archivos de configuración (como `.zshrc`, `.gitconfig`, etc.) versionados en Git:

```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

### B) Añadir claves SSH

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub  # Copia para añadir a GitHub
```

---

## 💡 Software adicional recomendado

| Categoría      | Aplicaciones               | Notas                                 |
| -------------- | -------------------------- | ------------------------------------- |
| Comunicación   | Slack, Discord, Zoom       |                                       |
| Productividad  | Notion, Raycast, Rectangle |                                       |
| Desarrollo     | Cursor (AI IDE), Warp      | Alternativa a VSCode/Terminal         |
| Monitorización | Stats, iStat Menus         | Temperatura, memoria, uso del sistema |
| Automatización | Raycast, Alfred            | Flujos de trabajo y automatización    |
| Audio          | VB-Audio, OBS, Krisp       | Filtros y control de audio            |
| Macros/Atajos  | Elgato Stream Deck + app   | Lanzadores, automatizaciones          |

---

## ✅ Checklist final para entorno listo

* [x] Crear estructura de carpetas
* [x] Configurar sincronización con Synology
* [x] Instalar software con Homebrew
* [x] Añadir claves SSH
* [x] Configurar dotfiles y alias
* [x] Activar Time Machine y backups en NAS

---

> *Este README forma parte del entorno profesional de desarrollo mantenido por \[tu nombre o empresa].*
> *Última actualización: 2025-08-07*
