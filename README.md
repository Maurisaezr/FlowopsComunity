# FlowOps Community Docker

Paquete Docker para levantar FlowOps Community sin publicar el codigo fuente de la aplicacion en este repositorio.

Este repositorio contiene solo el contenedor, Compose, migracion minima de SQLite y documentacion operativa.

## Objetivo

Permitir que un usuario con acceso al codigo de FlowOps pueda levantar una instancia local con Docker Compose y probar el MVP Community en pocos minutos.

La aplicacion queda disponible en:

```text
http://localhost:5000
```

## Requisitos

- Docker Engine o Docker Desktop.
- Docker Compose.
- Codigo fuente de FlowOps/Antigravity disponible localmente.

## Instalacion Rapida

Clona este repositorio:

```bash
git clone https://github.com/Maurisaezr/FlowopsComunity.git
cd FlowopsComunity
```

Copia o sincroniza el codigo de FlowOps dentro de `flowops-src`:

```bash
mkdir -p flowops-src
rsync -a /ruta/a/Antigravity/ flowops-src/
```

Levanta la Community:

```bash
docker compose up --build
```

Abre:

```text
http://localhost:5000
```

## Usar Otra Ruta De Codigo

Si no quieres copiar el codigo dentro del repo, crea un `.env` basado en `.env.example`:

```bash
cp .env.example .env
```

Edita:

```text
FLOWOPS_SOURCE_DIR=/ruta/a/Antigravity
FLOWOPS_PORT=5000
```

Luego ejecuta:

```bash
docker compose up --build
```

## Como Funciona

- Monta `FLOWOPS_SOURCE_DIR` como `/workspace:ro`.
- Copia el codigo a `/app` dentro del contenedor al arrancar.
- Excluye `.git`, caches, `node_modules`, backups, DB locales, `storage` y assets vendorizados pesados.
- Persiste los datos del lab en el volumen `flowops_lab_data`.
- Crea symlinks:
  - `/app/blockly_nodes.sqlite3` -> `/data/blockly_nodes.sqlite3`
  - `/app/storage` -> `/data/storage`

Esto permite probar Docker sin tocar el repo activo.

## Comandos Utiles

Detener:

```bash
docker compose down
```

Reiniciar con datos limpios:

```bash
docker compose down -v
docker compose up --build
```

## Alcance Del Lab

Incluido:

- Flask/UI actual.
- SQLite.
- GoJS + Blockly desde el codigo actual.
- Motor actual.
- Templates y plugins presentes en el repo.
- `git`, `openssh-client`, `curl`, `unzip`.

No incluido todavia:

- Docker CLI dentro del contenedor.
- `ansible-playbook`.
- `oc`.
- Terraform.
- Autenticacion.
- PostgreSQL.
- Redis/workers.
- Kubernetes/Helm.

## Riesgos Conocidos

- El codigo actual tiene rutas locales hardcodeadas; el lab las evita con symlinks.
- El arranque de `app.py` inicia scheduler, packs y sensores como efecto lateral.
- El contenedor minimo no prueba integraciones que requieren binarios externos no incluidos.
- No usar expuesto en red publica; FlowOps MVP no tiene autenticacion nativa.

## Si Ya Tenias Un Volumen Creado

Despues de cambios de schema o dependencias, reconstruye y parte limpio:

```bash
docker compose down -v
docker compose build --no-cache
docker compose up
```

## Alcance Community MVP

Esta version esta pensada para probar el primer valor del producto:

```text
Crear o abrir un proyecto -> ejecutar un flujo tecnico simple -> ver resultado/logs
```

No es una version Enterprise ni debe exponerse a internet sin controles adicionales.
