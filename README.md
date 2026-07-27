# FlowOps Community

FlowOps Community es la version Docker autocontenida para probar el MVP sin instalar dependencias locales ni clonar el codigo fuente principal.

La idea es simple:

```bash
docker compose up
```

Luego abrir:

```text
http://localhost:5000
```

## Uso Rapido

```bash
git clone https://github.com/Maurisaezr/FlowopsComunity.git
cd FlowopsComunity
docker compose up
```

Tambien se puede ejecutar directamente:

```bash
docker run --rm -p 5000:5000 -v flowops_community_data:/data ghcr.io/maurisaezr/flowops-community:latest
```

## Configuracion

Puerto local opcional:

```bash
FLOWOPS_PORT=5001 docker compose up
```

Los datos se guardan en el volumen Docker `flowops_community_data` montado en `/data` dentro del contenedor.

Para reiniciar con datos limpios:

```bash
docker compose down -v
docker compose up
```

## Alcance Community

Incluye:

- Backend Flask.
- SQLite embebido.
- UI actual con GoJS y Blockly.
- Engine actual.
- Templates basicos.
- Packs/plugins basicos que arrancan sin servicios externos.
- Bash/Shell, HTTP, parse, notify, file, control y formularios.
- SSH client para pruebas tecnicas simples.
- Scheduler local.

No incluye en esta distribucion Community:

- RBAC.
- Multiusuario.
- SSO/LDAP/SAML.
- PostgreSQL.
- Redis/workers distribuidos.
- Alta disponibilidad.
- Kubernetes/Helm/OpenShift packaging.
- Vault.
- Marketplace productivo.
- Binarios externos como `oc`, `terraform` o `ansible-playbook`.

## Seguridad

No expongas esta version directamente a internet. El MVP Community esta pensado para pruebas locales, demos tecnicas y early adopters controlados.

## Estado De La Imagen

La imagen objetivo es:

```text
ghcr.io/maurisaezr/flowops-community:latest
```

El repositorio no contiene el codigo fuente principal de FlowOps. Solo contiene Compose y documentacion para consumir la imagen Community.
