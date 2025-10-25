# 🚀 macOS Dev Setup - Backend Engineer Edition

> **Script automatizado e interactivo para configurar un entorno de desarrollo profesional en macOS**

[![macOS](https://img.shields.io/badge/macOS-12%2B-blue.svg)](https://www.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#)
[![Homebrew](https://img.shields.io/badge/Homebrew-Required-orange.svg)](https://brew.sh/)

Transforma tu Mac nuevo en un entorno de desarrollo completo para **Java/Kotlin + Spring Boot + Kubernetes + AWS** con un solo comando y selectores interactivos.

```
┌─────────────────────────────────────────────────────────┐
│  ⏱️  Tiempo: 30-45 min  │  💾 Espacio: ~15 GB          │
│  🖥️  Requiere: macOS 12+ (Monterey or newer)            │
└─────────────────────────────────────────────────────────┘
```

---

## 📑 Tabla de Contenidos

- [Prerequisitos](#-prerequisitos)
- [Inicio Rápido](#-inicio-rápido)
- [Características](#-características)
- [Herramientas Incluidas](#-herramientas-incluidas)
  - [Aplicaciones GUI](#️-aplicaciones-gui-16)
  - [Herramientas CLI](#️-herramientas-cli-43)
  - [SDKs JVM](#-sdks-jvm-8)
- [Guía de Herramientas](#-guía-de-herramientas-esenciales)
- [Instalación Manual](#-instalación-manual-de-herramientas)
- [Opciones Avanzadas](#-opciones-avanzadas)
- [Monitoreo](#-monitoreo)
- [FAQ](#-faq)
- [Troubleshooting](#-troubleshooting)

---

## 📋 Prerequisitos

### ¿Necesito instalar algo antes de ejecutar el script?

**Respuesta corta:** No. El script lo hace todo automáticamente.

**Respuesta larga:** El script requiere **Homebrew** (el gestor de paquetes de macOS), pero:

✅ **Si ya tienes Homebrew instalado** → El script lo detecta y continúa
✅ **Si NO tienes Homebrew** → El script lo instala automáticamente por ti

### ¿Qué es Homebrew y por qué es necesario?

[Homebrew](https://brew.sh/) es el gestor de paquetes estándar de facto para macOS, similar a `apt` en Ubuntu o `yum` en RedHat. Permite instalar herramientas de desarrollo con comandos simples como `brew install git`.

**El script usa Homebrew para instalar:**
- 16 aplicaciones GUI (Docker, IntelliJ, VS Code, etc.)
- 43 herramientas CLI (kubectl, terraform, jq, etc.)

### ¿Quiero instalar Homebrew manualmente antes? (opcional)

Si prefieres instalar Homebrew manualmente **antes** de ejecutar el script (por ejemplo, para entender el proceso):

```bash
# Comando oficial de Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Verificar que se instaló correctamente
brew --version
# Homebrew 4.x.x

# Ahora puedes ejecutar el script
./install-dev-tools.sh
```

**Nota para Apple Silicon (M1/M2/M3):** Homebrew se instala en `/opt/homebrew/` en lugar de `/usr/local/`. El script maneja esto automáticamente añadiendo Homebrew a tu PATH.

---

## 🎯 Inicio Rápido

```bash
# Clonar el repositorio (o descargar el script)
git clone https://github.com/vmart/mac-setup.git
cd mac-setup

# Ejecutar el script
chmod +x install-dev-tools.sh
./install-dev-tools.sh
```

### ¿Qué pasará?

1. **Advertencia de permisos**: Se te informa que necesitarás `sudo` (presiona Enter)
2. **Selector de GUI apps**: Elige 16 aplicaciones (Docker, IntelliJ, etc.)
3. **Selector de CLI tools**: Elige 43 herramientas (kubectl, terraform, jq, etc.)
4. **Selector de JVM SDKs**: Elige 8 SDKs (Java, Maven, Gradle, Kotlin, etc.)
5. **Instalación automática**: Todo se instala sin intervención
6. **Reporte final**: Ver estadísticas de instalación

**Por defecto todas las herramientas están seleccionadas** (excepto Cursor que es opcional).

Usa `Espacio` para desmarcar, `Enter` para confirmar cada selector.

### Ver qué se instalará sin instalar

```bash
./install-dev-tools.sh --dry-run
```

---

## ✨ Características

- ✅ **Interfaz interactiva** con checkboxes visuales (powered by [gum](https://github.com/charmbracelet/gum))
- ✅ **Idempotente** - Seguro ejecutar múltiples veces
- ✅ **Modo `--dry-run`** - Ver qué se instalará sin instalar nada
- ✅ **Logging completo** - Todas las operaciones en `install-dev-tools.log`
- ✅ **Validación de selecciones** - No rompe si cancelas un selector
- ✅ **Apple Silicon ready** - Fix automático de PATH para M1/M2/M3
- ✅ **Configuración automática** - Aliases, Oh My Zsh, versiones por defecto

---

## 📦 Herramientas Incluidas

### 🖥️ Aplicaciones GUI (16)

#### **Desarrollo**

| Aplicación | Descripción | Instalación manual |
|-----------|-------------|-------------------|
| **Docker** | Plataforma de contenedores - esencial para ejecutar servicios localmente (PostgreSQL, Redis, Kafka) sin instalación nativa | `brew install --cask docker` |
| **IntelliJ IDEA** | IDE completo para Java/Kotlin con Spring Boot integrado, refactoring avanzado y debugging | `brew install --cask intellij-idea` |
| **VS Code** | Editor ligero y universal para cualquier lenguaje - ideal para scripts, Terraform, YAML de K8s | `brew install --cask visual-studio-code` |
| **Cursor** 🔸 | Editor basado en VS Code con IA integrada para autocompletado inteligente (opcional) | `brew install --cask cursor` |
| **Postman** | Cliente REST/GraphQL estándar de industria - crear colecciones, tests automatizados, workspaces compartidos | `brew install --cask postman` |
| **Bruno** | Cliente API git-friendly - colecciones versionables en archivos `.bru` locales, sin cuenta cloud requerida | `brew install --cask bruno` |
| **DBeaver** | Cliente SQL universal que soporta PostgreSQL, MySQL, Oracle, SQL Server - ideal para explorar esquemas | `brew install --cask dbeaver-community` |
| **iTerm2** | Terminal macOS con splits, búsqueda, hotkeys, temas - reemplazo superior a Terminal.app | `brew install --cask iterm2` |

#### **Productividad**

| Aplicación | Descripción | Instalación manual |
|-----------|-------------|-------------------|
| **Google Chrome** | Navegador principal para desarrollo web - DevTools avanzadas, extensiones útiles | `brew install --cask google-chrome` |
| **Notion** | Documentación de equipo, wikis, roadmaps - alternativa moderna a Confluence | `brew install --cask notion` |
| **Slack** | Comunicación de equipo - integra con GitHub, JIRA, alertas de K8s | `brew install --cask slack` |

#### **Utilidades macOS**

| Aplicación | Descripción | Instalación manual |
|-----------|-------------|-------------------|
| **AltTab** | Cambio entre ventanas estilo Windows (Alt+Tab real) - útil si vienes de Windows/Linux | `brew install --cask alt-tab` |
| **Maccy** | Historial de portapapeles con búsqueda - recupera comandos/URLs copiados hace horas | `brew install --cask maccy` |
| **Lightshot** | Capturas de pantalla con editor instantáneo - marca áreas, añade flechas, sube a cloud | `brew install --cask lightshot` |
| **MonitorControl** | Controlar brillo de monitores externos desde Mac (sin botones físicos del monitor) | `brew install --cask monitorcontrol` |
| **lazydocker** | Interfaz visual TUI para Docker - ver logs, stats, gestionar containers sin memorizar comandos | `brew install --cask lazydocker` |

🔸 = Opcional por defecto

> **Nota sobre Rectangle:** macOS 15+ (Sequoia) incluye gestor de ventanas nativo ("Window Tiling"), por lo que Rectangle ya no es necesario.

---

### ⚙️ Herramientas CLI (43)

#### **🐳 Kubernetes & Containers** (7 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **kubectl** | CLI oficial de Kubernetes - gestiona deployments, services, configs | Ejecutar cualquier operación K8s: deploy apps, ver pods, aplicar YAMLs, debug |
| **stern** | Ver logs de múltiples pods simultáneamente con filtros y colores | Debugging cuando tienes 10 réplicas de un pod y quieres ver logs de TODAS en tiempo real |
| **helm** | Package manager para instalar apps complejas en K8s (PostgreSQL, Redis, Kafka) | Desplegar stacks completos en lugar de escribir decenas de YAMLs manualmente |
| **k9s** | Terminal UI interactiva para navegar cluster K8s visualmente | Explorar cluster sin memorizar comandos kubectl - ver pods/logs/configs con teclas |
| **minikube** | Kubernetes local en tu Mac para desarrollo | Probar manifiestos K8s antes de subirlos a staging - desarrollar sin consumir cloud |
| **kubectx** | Cambiar entre clusters (dev/staging/prod) sin editar kubeconfig | Evitar accidentalmente deployar a producción - cambio rápido entre ambientes |
| **kubens** | Cambiar namespace activo sin escribir `-n namespace` en cada comando | Trabajar en namespace específico y ejecutar kubectl sin repetir el flag -n |

**Ejemplos prácticos:**
```bash
# Escenario 1: Tu app en staging tiene un error, necesitas ver logs
kubectx staging-cluster           # Cambio a cluster de staging
kubens microservices              # Me posiciono en namespace correcto
stern user-service --tail 50      # Ver logs de TODAS las réplicas de user-service (50 líneas recientes)
# Resultado: Ves logs de user-service-7f8d9-abc, user-service-7f8d9-def, etc. todos mezclados con colores

# Escenario 2: Quieres explorar qué está consumiendo recursos
k9s                               # Se abre interfaz visual
# Presiona '0' para ver todos los pods de todos los namespaces
# Presiona 's' para ordenar por CPU usage
# Enter en un pod para ver logs
# 'd' para describir el pod (ver eventos de crashes)

# Escenario 3: Instalar PostgreSQL en minikube local
minikube start                    # Arranca K8s local
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-postgres bitnami/postgresql
# Resultado: PostgreSQL corriendo en K8s local en 2 minutos (sin Docker Compose)

# Escenario 4: Aplicar cambios a un deployment
kubectl apply -f deployment.yaml  # Actualiza deployment
kubectl rollout status deployment/user-service  # Ver progreso del rollout
kubectl get pods                  # Ver si los nuevos pods están corriendo
```

---

#### **☁️ Cloud & Infrastructure** (3 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **awscli** | CLI para gestionar servicios AWS (S3, EC2, RDS, Lambda, etc.) | Automatizar tareas AWS: deploy Lambda, consultar logs CloudWatch, listar recursos |
| **aws-vault** | Almacena credenciales AWS en macOS Keychain y genera tokens MFA temporales | Evitar guardar credenciales en texto plano - rotación automática - soporte MFA |
| **terraform** | Define infraestructura como código (IaC) - crea VPCs, clusters, databases con archivos `.tf` | Mantener infraestructura versionada en Git - reproducir entornos - evitar click-ops manual |

**Ejemplos prácticos:**
```bash
# Escenario 1: Configurar AWS de forma segura (sin credenciales en ~/.aws/credentials)
aws-vault add production
# Enter Access Key ID: AKIA...
# Enter Secret Access Key: ****
# Guardado en macOS Keychain (encriptado)

aws-vault exec production -- aws s3 ls
# aws-vault genera token temporal de 1 hora, ejecuta comando, token expira automáticamente

# Escenario 2: Crear infraestructura reproducible
# Archivo: main.tf
# resource "aws_instance" "web" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t3.micro"
# }

terraform init                    # Descarga providers (AWS, etc.)
terraform plan                    # Preview de cambios (sin aplicar)
# Plan: 1 to add, 0 to change, 0 to destroy

terraform apply                   # Crea recursos reales en AWS
# aws_instance.web: Creating...
# aws_instance.web: Creation complete after 45s

# Beneficio: Tu infra está en Git, puedes replicar staging/prod idénticamente
```

---

#### **☕ Java/JDK** (3 versiones)

| Versión | Descripción | Instalación manual |
|---------|-------------|-------------------|
| **openjdk@25** | Java 25 (latest) | `brew install openjdk@25` |
| **openjdk@21** | Java 21 LTS | `brew install openjdk@21` |
| **openjdk@17** | Java 17 LTS | `brew install openjdk@17` |

**Ejemplo de uso:**
```bash
# Ver versión instalada
java --version

# Cambiar versión (vía SDKMAN!)
sdk use java 21-tem
```

---

#### **📊 Data Processing** (7 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **jq** | Parser/transformador JSON - filtra, mapea, agrupa datos JSON como SQL | Analizar respuestas de APIs - extraer campos específicos de JSONs gigantes - transformar datos |
| **yq** | Lo mismo que jq pero para YAML - edita configs de K8s/Docker sin abrir editor | Cambiar replicas en deployment.yaml - actualizar versión de imagen - merge de YAMLs |
| **ripgrep (rg)** | Grep ultra-rápido que ignora .gitignore automáticamente - 10x más rápido que grep | Buscar "UserService" en 50k archivos Java instantáneamente - encontrar todos los TODOs |
| **bat** | cat con syntax highlighting y números de línea - integración Git para ver diffs | Ver código con colores para leer logs/configs rápido - reemplaza cat en el día a día |
| **eza** | ls moderno con colores, iconos, Git status integrado - más legible | Explorar proyectos visualemente - ver permisos/fechas/tamaños de forma clara |
| **fd** | find simplificado y rápido - sintaxis intuitiva, ignora .gitignore | Encontrar archivos por nombre sin sintaxis compleja de find - búsquedas rápidas |
| **fzf** | Fuzzy finder para buscar interactivamente en cualquier lista | Buscar comandos en historial Ctrl+R - abrir archivos rápido - filtrar outputs largos |

**Ejemplos prácticos:**
```bash
# Escenario 1: API devuelve JSON gigante, solo quieres usuarios activos con email @gmail
curl https://api.example.com/users | jq '.data[] | select(.active == true and (.email | contains("@gmail")))'
# Output: Solo usuarios activos con Gmail
# {
#   "id": 123,
#   "name": "Juan Pérez",
#   "email": "juan@gmail.com",
#   "active": true
# }

# Escenario 2: Necesitas cambiar replicas de 3 a 10 en deployment.yaml de K8s
yq -i '.spec.replicas = 10' deployment.yaml
# -i = in-place (modifica el archivo directamente)
# Antes: replicas: 3
# Después: replicas: 10

# Escenario 3: Buscar dónde se usa "UserRepository" en tu proyecto de 500 archivos
rg "UserRepository" --type java
# src/main/java/service/UserService.java:15:import com.example.UserRepository;
# src/main/java/controller/UserController.java:8:private UserRepository userRepo;
# Resultado en < 0.1 segundos (grep tardaría segundos)

# Escenario 4: Ver logs con colores para detectar errores rápido
bat application.log
# Syntax highlighting automático detecta fechas, IPs, niveles ERROR/WARN

# Escenario 5: Buscar un archivo de config en proyecto grande
fd application.yml
# src/main/resources/application.yml
# src/test/resources/application.yml

# Escenario 6: Buscar en historial de comandos sin recordar nombre exacto
# Presiona Ctrl+R y empieza a escribir
# kubectl get pods production
#          ^ aparece interactivamente mientras escribes
```

---

#### **🌐 APIs & Network** (4 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **httpie** | curl amigable con colores, autocompletado y sintaxis simple | Probar APIs REST rápido - sintaxis más clara que curl - ideal para desarrollo |
| **grpcurl** | Cliente gRPC de línea de comandos - como curl pero para gRPC | Probar microservicios gRPC - debug de servicios internos - explorar métodos disponibles |
| **protobuf** | Compilador de Protocol Buffers - genera código Java/Kotlin desde .proto | Trabajar con gRPC - definir contratos de APIs - serialización eficiente |
| **mkcert** | Genera certificados SSL confiables para desarrollo local | HTTPS en localhost sin warnings - probar integraciones que requieren SSL |

**Ejemplos prácticos:**
```bash
# Escenario 1: Probar endpoint REST (httpie vs curl)
# Con curl (complejo):
curl -X POST https://api.example.com/users \
  -H "Authorization: Bearer token123" \
  -H "Content-Type: application/json" \
  -d '{"name":"Juan","email":"juan@example.com"}'

# Con httpie (simple):
http POST https://api.example.com/users \
  Authorization:"Bearer token123" \
  name=Juan \
  email=juan@example.com
# Output con colores, indentación automática, headers visibles

# Escenario 2: Debuggear microservicio gRPC
grpcurl -plaintext localhost:9090 list
# grpc.reflection.v1alpha.ServerReflection
# user.UserService
# payment.PaymentService

grpcurl -plaintext localhost:9090 user.UserService/GetUser
# Lista métodos del servicio

grpcurl -plaintext -d '{"id": 123}' localhost:9090 user.UserService/GetUser
# Llama al método con payload JSON

# Escenario 3: Generar clases Java desde contratos .proto
# Archivo: user.proto
# message User {
#   int64 id = 1;
#   string name = 2;
# }

protoc --java_out=src/main/java user.proto
# Genera: src/main/java/UserOuterClass.java con clase User

# Escenario 4: Desarrollar con HTTPS local
mkcert -install                  # Instala CA local
mkcert localhost 127.0.0.1       # Genera certificados
# Created: localhost.pem, localhost-key.pem

# Ahora tu app Spring Boot puede usar HTTPS:
# server.ssl.key-store=localhost.pem
# Navegador confía en el certificado (sin warnings ❌🔒)
```

---

#### **🗄️ Databases** (1 herramienta)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **pgcli** | PostgreSQL CLI con autocompletado inteligente, syntax highlighting y formato de tablas | Consultar bases de datos sin DBeaver - queries rápidas - explorar esquemas de producción/RDS |

**Ejemplos prácticos:**
```bash
# Escenario 1: Conectar a PostgreSQL local (Docker)
docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=secret postgres
pgcli -h localhost -U postgres
# Server: PostgreSQL 16.1
# postgres@localhost:postgres>

# Dentro de pgcli tienes autocompletado:
SELECT * FROM us[TAB]        # Autocompleta a "users"
SELECT id, na[TAB]           # Autocompleta a "name" (columnas de users)

# Escenario 2: Conectar a RDS de producción
pgcli postgresql://admin:password@my-app.abc123.us-east-1.rds.amazonaws.com:5432/production

# Escenario 3: Comandos útiles dentro de pgcli
\dt                          # Listar todas las tablas
# Schema | Name         | Type  | Owner
# public | users        | table | postgres
# public | orders       | table | postgres
# public | payments     | table | postgres

\d users                     # Describir estructura de tabla "users"
# Column    | Type                  | Nullable
# id        | integer               | not null
# email     | character varying(255)| not null
# created_at| timestamp             |

SELECT COUNT(*) FROM users WHERE created_at > '2024-01-01';
# Output formateado con colores:
# +-------+
# | count |
# +-------+
# | 15847 |
# +-------+

# Escenario 4: Exportar resultados a CSV
\o users_export.csv
SELECT id, email, created_at FROM users WHERE active = true;
\o
# Guardado en users_export.csv
```

---

#### **🧪 Testing & Quality** (3 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **k6** | Load testing para verificar rendimiento de APIs bajo carga real | Antes de lanzar a prod: simular 1000 usuarios concurrentes y detectar cuellos de botella/memory leaks |
| **ktlint** | Formatter/linter que fuerza estilo Kotlin oficial (como Prettier para JS) | En CI/CD para asegurar que todo el equipo usa el mismo formato - auto-fix disponible |
| **detekt** | Analiza código Kotlin para detectar code smells, complejidad, bugs potenciales | Code reviews automatizadas - encuentra funciones demasiado largas, código duplicado, vulnerabilidades |

**Ejemplos prácticos:**
```bash
# Escenario 1: Quieres saber si tu API aguanta tráfico Black Friday
# Crear archivo test.js:
# import http from 'k6/http';
# export default function() {
#   http.get('https://api.myapp.com/products');
# }

k6 run --vus 100 --duration 30s test.js
# --vus 100: Simula 100 usuarios concurrentes
# --duration 30s: Durante 30 segundos

# Resultado: Obtienes métricas reales:
# ✓ http_req_duration: avg=245ms p95=890ms  <- P95 bajo 1 segundo = OK
# ✓ http_req_failed: 0.00%                   <- No hay errores = OK
# ✓ http_reqs: 3847 (128/s)                  <- Throughput real
#
# Conclusión: Tu API maneja 128 req/s sin errores. Si esperas más tráfico, necesitas escalar.

# Escenario 2: El código Kotlin de tu equipo está inconsistente
ktlint "src/**/*.kt"
# Muestra todos los errores de formato (indentación, espacios, etc.)

ktlint -F "src/**/*.kt"
# -F = auto-fix. Arregla automáticamente todos los problemas de formato

# Agregar a pre-commit hook:
# #!/bin/sh
# ktlint --format "src/**/*.kt"

# Escenario 3: Code review detecta problemas antes de merge
detekt --input src/main/kotlin --report html:build/reports/detekt.html

# Abre build/reports/detekt.html y ves:
# ⚠️ ComplexMethod: UserService.createUser() tiene complejidad ciclomática 15 (máx 10)
# ⚠️ LongMethod: OrderProcessor.process() tiene 120 líneas (máx 60)
# ⚠️ TooManyFunctions: PaymentController tiene 18 funciones (máx 11)
#
# Te ayuda a refactorizar ANTES de que el código se vuelva inmantenible
```

---

#### **🔧 DevOps & System** (8 herramientas)

| Herramienta | Descripción | Cuándo usarla |
|------------|-------------|---------------|
| **git** | Control de versiones distribuido - base de cualquier workflow moderno | Versionar código, crear branches, colaborar en equipo - esencial |
| **gh** | GitHub CLI - gestiona PRs, issues, releases sin salir de terminal | Crear/revisar PRs sin navegador - automatizar workflows - ver CI status |
| **tmux** | Mantén sesiones de terminal persistentes con splits y ventanas | SSH a servidores - mantener procesos corriendo - workflow multi-panel |
| **direnv** | Carga variables de entorno automáticamente al entrar a carpeta de proyecto | Diferentes DB_URLs por proyecto - secrets locales - configs por ambiente |
| **sops** | Encripta archivos YAML/JSON para guardar secrets en Git de forma segura | Versionar secrets.yaml encriptados - integración con AWS KMS/GPG |
| **dive** | Explora capas de imágenes Docker para optimizar tamaño | Encontrar qué añade 500MB a tu imagen - eliminar archivos innecesarios |
| **htop** | Monitor de procesos interactivo con CPU/RAM/tree view | Ver qué proceso consume 100% CPU - matar procesos - diagnosticar lentitud |
| **watch** | Ejecuta comando repetidamente mostrando output actualizado | Monitorear kubectl get pods cada 2 segundos - ver progreso de deploys |

**Ejemplos prácticos:**
```bash
# Escenario 1: Crear PR sin abrir navegador
gh pr create --title "Add user authentication" --body "Implements JWT auth"
# ✓ Created pull request #42: Add user authentication
# https://github.com/myorg/myrepo/pull/42

gh pr list                        # Ver todos los PRs abiertos
gh pr view 42                     # Ver detalles del PR #42
gh pr merge 42                    # Mergear directamente desde terminal

# Escenario 2: Trabajar en servidor remoto sin perder sesión
ssh user@server
tmux new -s backend               # Crear sesión llamada "backend"
# Dentro de tmux:
tail -f /var/log/app.log         # Dejas logs corriendo

# Te desconectas por error de red... al volver:
ssh user@server
tmux attach -t backend           # ¡Los logs siguen corriendo!

# Escenario 3: Proyecto necesita DB local, otro DB staging
cd ~/Work/project-local
echo 'export DATABASE_URL=postgres://localhost/dev' > .envrc
direnv allow
echo $DATABASE_URL               # postgres://localhost/dev

cd ~/Work/project-staging
echo 'export DATABASE_URL=postgres://staging.aws.com/db' > .envrc
direnv allow
echo $DATABASE_URL               # postgres://staging.aws.com/db (cambió automáticamente!)

# Escenario 4: Tu imagen Docker es de 2GB, debería ser 500MB
dive myapp:latest
# Ves cada capa:
# Layer 1: 800MB  <- ¿Qué es esto?
# Layer 2: 600MB  <- Instalaste dependencias que no usas
# Layer 3: 400MB
# Resultado: Optimizas Dockerfile, reduces a 600MB

# Escenario 5: Deployment lento, ver qué pod está reiniciando
watch -n 2 'kubectl get pods'
# Every 2s: kubectl get pods
# NAME                     READY   STATUS
# user-service-abc         1/1     Running
# payment-service-def      0/1     CrashLoopBackOff  <- Este es el problema
```

---

#### **📦 Version Managers** (2 herramientas)

| Herramienta | Descripción | Instalación manual |
|------------|-------------|-------------------|
| **fnm** | Fast Node Manager (alternativa a nvm) | `brew install fnm` |
| **pyenv** | Python version manager | `brew install pyenv` |

**Ejemplo de uso:**
```bash
# Instalar y usar Node 20
fnm install 20
fnm use 20

# Configurar fnm en .zshrc (automático en el script)
eval "$(fnm env --use-on-cd)"

# Instalar Python 3.12
pyenv install 3.12.0
pyenv global 3.12.0
```

---

#### **🛠️ Utilidades** (6 herramientas)

| Herramienta | Descripción | Instalación manual |
|------------|-------------|-------------------|
| **node** | JavaScript runtime | `brew install node` |
| **python** | Python 3 | `brew install python` |
| **wget** | Descarga de archivos | `brew install wget` |
| **unzip** | Descomprimir archivos | `brew install unzip` |
| **tree** | Visualizador de árbol de dirs | `brew install tree` |

---

### ☕ SDKs JVM (8)

Instalados vía [SDKMAN!](https://sdkman.io/) - **gestor de versiones para herramientas JVM**

> **¿Qué es SDKMAN!?** Es como `nvm` para Node o `pyenv` para Python, pero para el ecosistema JVM. Te permite tener **múltiples versiones de Java/Kotlin/Gradle instaladas simultáneamente** y cambiar entre ellas por proyecto.
>
> El script **instala SDKMAN! automáticamente** antes de instalar los SDKs, por lo que no necesitas configuración manual.

| SDK | Descripción | Instalación manual |
|-----|-------------|-------------------|
| **Java 25-tem** | Java 25 (Temurin) - versión más reciente | `sdk install java 25-tem` |
| **Java 21-tem** | Java 21 LTS (Temurin) - LTS enterprise | `sdk install java 21-tem` |
| **Java 17-tem** | Java 17 LTS (Temurin) - LTS legacy | `sdk install java 17-tem` |
| **Maven** | Build tool tradicional - estándar enterprise | `sdk install maven` |
| **Gradle** | Build tool moderno con Kotlin DSL - más rápido que Maven | `sdk install gradle` |
| **Kotlin** | Lenguaje JVM moderno - interoperable con Java | `sdk install kotlin` |
| **Spring Boot CLI** | CLI para generar proyectos Spring Boot | `sdk install springboot` |
| **JBang** | Ejecutar scripts Java sin proyecto Maven/Gradle - ideal para utilidades | `sdk install jbang` |

#### 🔄 Cambiar entre versiones de Java

**El script instala 3 versiones de Java** (25, 21, 17) porque diferentes proyectos pueden requerir diferentes versiones. Aquí cómo cambiarlas:

```bash
# 1️⃣ Ver qué versión está activa actualmente
java -version
# openjdk version "25" ...

sdk current java
# Using java version 25-tem

# 2️⃣ Cambiar a Java 21 SOLO en la terminal actual (temporal)
sdk use java 21-tem
# Using java version 21-tem in this shell.

java -version
# openjdk version "21.0.1" ...

# 3️⃣ Cambiar versión por defecto para TODAS las terminales futuras
sdk default java 21-tem
# Default java version set to 21-tem

# 4️⃣ Ver todas las versiones instaladas
sdk list java
# ================================================================================
# Available Java Versions
# ================================================================================
#  * 25-tem        > /Users/you/.sdkman/candidates/java/25-tem
#  * 21-tem        > /Users/you/.sdkman/candidates/java/21-tem
#  * 17-tem        > /Users/you/.sdkman/candidates/java/17-tem
```

#### 📁 Configuración por proyecto (avanzado)

Puedes crear un archivo `.sdkmanrc` en la raíz de tu proyecto para fijar versiones:

```bash
# En tu proyecto Spring Boot que requiere Java 21
cd ~/Work/my-spring-boot-project
echo "java=21-tem" > .sdkmanrc

# SDKMAN! cambiará automáticamente cuando entres al directorio
cd ~/Work/my-spring-boot-project
# Using java version 21-tem (set by /Users/you/Work/my-spring-boot-project/.sdkmanrc)
```

#### 🛠️ Otros ejemplos útiles

```bash
# Actualizar Gradle a la última versión
sdk upgrade gradle

# Instalar una versión específica de Java
sdk install java 11.0.21-tem

# Crear proyecto Spring Boot con Java 21
sdk use java 21-tem
spring init --dependencies=web,data-jpa,postgresql my-project

# Ejecutar script Java sin proyecto completo
jbang HelloWorld.java
# JBang descarga dependencias automáticamente si las declaras en comentarios:
# //DEPS org.springframework.boot:spring-boot-starter-web:3.2.0
```

---

## 🎓 Guía de Herramientas Esenciales

### Para Backend Engineers

**Día a día:**
- `kubectl` + `k9s` → Gestionar deployments en Kubernetes
- `stern` → Ver logs de múltiples pods a la vez
- `jq` + `yq` → Procesar JSON de APIs y YAML de K8s
- `httpie` → Probar endpoints durante desarrollo
- `pgcli` → Conectar a PostgreSQL (local o RDS)
- `gh` → Crear PRs, revisar código, gestionar issues

**Debugging:**
- `k9s` → UI visual para explorar cluster K8s
- `dive` → Ver qué está ocupando espacio en imágenes Docker
- `stern` → Logs en tiempo real de múltiples pods
- `bat` → Ver logs con syntax highlighting

**Productividad:**
- `fzf` → Búsqueda interactiva en historial de comandos
- `ripgrep` → Buscar código instantáneamente
- `Rectangle` → Organizar ventanas con atajos (⌃⌥←/→)
- `Maccy` → Acceder a historial de portapapeles

---

## 📋 Instalación Manual de Herramientas

Si solo quieres instalar herramientas específicas sin usar el script:

### Instalar una GUI app

```bash
brew install --cask <nombre>

# Ejemplos:
brew install --cask docker
brew install --cask intellij-idea
brew install --cask rectangle
```

### Instalar una CLI tool

```bash
brew install <nombre>

# Ejemplos:
brew install kubectl
brew install gh
brew install stern
brew install jq
```

### Instalar un JVM SDK

```bash
# Primero instalar SDKMAN!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Luego instalar SDK
sdk install java 21-tem
sdk install maven
sdk install gradle
```

---

## 🛠️ Opciones Avanzadas

### Modo Dry Run

Ver qué se instalaría sin instalar nada:

```bash
./install-dev-tools.sh --dry-run
```

Esto mostrará:
- Todas las herramientas seleccionadas por defecto
- Operaciones que se ejecutarían
- Sin hacer cambios reales en el sistema

### Personalizar herramientas disponibles

Edita `install-dev-tools.sh`:

```bash
# GUI apps (línea ~134)
all_casks=(
  "docker"
  "google-chrome"
  # ... añade o quita aquí
)

# CLI tools (línea ~180)
all_cli_tools=(
  "git"
  "kubectl"
  # ... añade o quita aquí
)

# JVM SDKs (línea ~369)
all_sdks=(
  "java-25-tem"
  "maven"
  # ... añade o quita aquí
)
```

### Configuraciones automáticas

El script configura:

| Configuración | Detalles |
|---------------|----------|
| **Carpetas** | `~/00-MyStuff`, `~/Work` |
| **Aliases** | Ejemplos comentados en `.zshrc` - descomenta y personaliza según tu estructura de carpetas |
| **Java default** | Java 25-tem como default del sistema |
| **Oh My Zsh** | Framework Zsh con temas y plugins |
| **fnm** | Node version manager configurado |
| **pyenv** | Python version manager configurado |

**Personalizar aliases:** Después de ejecutar el script, edita `~/.zshrc` y descomenta/modifica los aliases de ejemplo:
```bash
# Busca esta sección en ~/.zshrc:
# Custom aliases
# alias repos='cd ~/Work/repositories'
# alias projects='cd ~/Projects'
# alias dev='cd ~/Development'

# Descomenta y personaliza según tu estructura:
alias repos='cd ~/Work/repositories'
```

---

## 📊 Monitoreo

### Logs en tiempo real

```bash
tail -f install-dev-tools.log
```

### Ver solo errores

```bash
grep "❌ ERROR" install-dev-tools.log
```

### Contar instalaciones exitosas

```bash
grep -c "✅" install-dev-tools.log
```

### Reporte final

Al terminar verás:

```
=== FINAL INSTALLATION REPORT ===
ℹ️  Total successful operations: 54
ℹ️  Total errors: 0
ℹ️  Total items already installed/configured: 12

✅ Installation completed without errors
ℹ️  Full log saved at: /Users/you/mac-setup/install-dev-tools.log
ℹ️  Restart your terminal to apply changes
```

---

## ❓ FAQ

### ¿Cuánto tiempo tarda?

- **Primera instalación**: 30-45 minutos (depende de conexión a internet)
- **Re-ejecución**: 2-5 minutos (solo instala lo que falta)

### ¿Cuánto espacio ocupa?

Aproximadamente **15 GB** en total:
- Docker Desktop: ~5 GB
- IntelliJ IDEA: ~2 GB
- Java SDKs (3 versiones): ~1.5 GB
- Homebrew + CLI tools: ~2 GB
- Resto de apps GUI: ~4.5 GB

### ¿Puedo ejecutarlo varias veces?

**Sí, es totalmente seguro.** El script es idempotente:
- Solo instala paquetes que faltan
- No duplica configuraciones en `.zshrc`
- Actualiza SDKs de SDKMAN! si ya existen

### ¿Qué pasa si cancelo un selector (Ctrl+C)?

El script valida selecciones vacías y continúa:
```
ℹ️  No GUI applications selected, skipping...
```

### ¿Funciona en Apple Silicon (M1/M2/M3)?

**Sí.** El script incluye un fix automático de PATH para Apple Silicon:

```bash
# Líneas 100-105
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
```

### ¿Puedo desinstalar todo después?

Sí, usando Homebrew:

```bash
# Desinstalar una app GUI
brew uninstall --cask docker

# Desinstalar una CLI tool
brew uninstall kubectl

# Desinstalar un SDK
sdk uninstall java 25-tem
```

### ¿Por qué no incluye Micronaut ni Quarkus?

Este script está optimizado para **Spring Boot**, el framework más usado en entornos enterprise Java. Si necesitas Micronaut o Quarkus:

```bash
sdk install micronaut
sdk install quarkus
```

### ¿Por qué Cursor es opcional?

Cursor es un editor AI excelente pero:
- Ya tienes IntelliJ (IDE completo) y VS Code (editor ligero)
- No todos necesitan 3 editores
- Por defecto está desmarcado, pero puedes seleccionarlo si lo prefieres

---

## 🛠️ Troubleshooting

### Homebrew no se encuentra después de instalarlo

**Problema:** En Apple Silicon, Homebrew se instala en `/opt/homebrew/` pero no está en el PATH.

**Solución:** El script lo soluciona automáticamente (líneas 100-105). Si ejecutas manualmente:

```bash
# Añadir a PATH temporalmente
eval "$(/opt/homebrew/bin/brew shellenv)"

# Añadir a .zshrc permanentemente
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
```

### Error: "sudo password timeout"

**Problema:** Te alejas del Mac y la sesión sudo expira.

**Solución:** El script ahora advierte al inicio que necesitará sudo. Mantente cerca durante los primeros 5 minutos.

### SDKMAN! no funciona después de instalación

**Problema:** SDKMAN! requiere sourcing de script en shell.

**Solución:**

```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# O reinicia tu terminal
```

El script añade esto automáticamente a `.zshrc`.

### Docker no arranca después de instalación

**Problema:** Docker Desktop requiere aprobación en "Configuración del Sistema".

**Solución:**

1. Ve a **System Settings** → **Privacy & Security**
2. Busca el mensaje de Docker Desktop
3. Haz clic en **Allow**
4. Reinicia Docker Desktop

### Oh My Zsh sobrescribió mi .zshrc

**Problema:** Oh My Zsh crea un `.zshrc` nuevo.

**Solución:** El script usa `RUNZSH=no` para evitar esto. Si ocurre, tus aliases están al final del archivo nuevo.

### Rectangle no funciona

**Problema:** macOS requiere permisos de accesibilidad.

**Solución:**

1. Ve a **System Settings** → **Privacy & Security** → **Accessibility**
2. Añade Rectangle
3. Reinicia Rectangle

### fnm: command not found

**Problema:** fnm no está en PATH.

**Solución:**

```bash
# Añadir a .zshrc
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
source ~/.zshrc
```

---

## 🔒 Seguridad

**Fuentes oficiales:**
- ✅ Homebrew Casks y Formulae oficiales
- ✅ SDKMAN! repositorios verificados
- ✅ Oh My Zsh repo oficial de GitHub

**Para entornos corporativos:**
- Consulta con IT antes de ejecutar
- Docker puede requerir aprobaciones especiales
- Verifica políticas de MDM de tu empresa
- Algunas herramientas cloud (awscli, terraform) pueden requerir autorización

---

## 📚 Recursos

### Documentación Oficial
- [Docker](https://docs.docker.com) | [Kubernetes](https://kubernetes.io/docs) | [Terraform](https://terraform.io/docs)
- [Spring Boot](https://spring.io/guides) | [AWS CLI](https://docs.aws.amazon.com/cli/)
- [Homebrew](https://docs.brew.sh/) | [SDKMAN!](https://sdkman.io/usage)

### Tutoriales Recomendados
- [jq Tutorial](https://stedolan.github.io/jq/tutorial/) - Dominar procesamiento JSON
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [k9s Cheat Sheet](https://k9scli.io/)

### Herramientas Modernas
- [gum](https://github.com/charmbracelet/gum) - CLI interactivo (usado en este script)
- [Charm](https://charm.sh/) - Herramientas modernas de CLI
- [Modern Unix Tools](https://github.com/ibraheemdev/modern-unix) - Lista curada

---

## 🤝 Contribuir

¿Encontraste un bug o quieres sugerir una herramienta?

1. Abre un [Issue](https://github.com/vmart/mac-setup/issues)
2. Describe el problema o la mejora
3. Si es una nueva herramienta, explica por qué es esencial para Backend Engineers

---

## 📝 Licencia

MIT License - Libre para modificar y adaptar.

---

## 🙏 Créditos

Creado y mantenido por **Victor Martínez** ([@vmart](https://github.com/vmart))

Optimizado para **Tech Leads y Backend Engineers** trabajando con:
- ☕ Java/Kotlin + Spring Boot
- 🐳 Docker + Kubernetes
- ☁️ AWS
- 🛠️ DevOps tooling moderno

**Última actualización:** Enero 2025

---

**⭐ Si te resultó útil, deja una estrella en GitHub!**
