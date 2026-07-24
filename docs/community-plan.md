# FlowOps Community Plan

## Principio

Community no debe ser FlowOps Enterprise recortado. Debe ser la forma mas rapida de comprobar el valor del producto.

Meta:

```text
docker compose up
```

En menos de 10 minutos, el usuario debe poder ejecutar un flujo simple y ver evidencia.

## Problema De Los Primeros 5 Minutos

El primer recorrido debe responder:

```text
¿Puedo convertir una operacion tecnica en un flujo ejecutable, visible y trazable?
```

Recorrido recomendado:

1. Abrir FlowOps.
2. Crear o abrir proyecto demo.
3. Ejecutar un flujo Bash local o SSH simple.
4. Ver logs y estado por nodo.
5. Entender que el flujo puede reutilizarse.

## Que Entra En Community

- Flask backend actual.
- SQLite.
- UI actual con GoJS + Blockly.
- Engine actual.
- Templates basicos.
- Bash/Shell.
- SSH.
- Webhook/API/manual/schedule si arrancan sin dependencias externas.
- Plugins ya incluidos si no rompen el arranque.
- Docker Compose.
- README de 10 minutos.

## Que Queda Fuera

- RBAC.
- Multiusuario.
- SSO/LDAP/SAML.
- PostgreSQL.
- Redis/Celery/workers distribuidos.
- HA.
- Kubernetes/Helm/OpenShift packaging.
- Vault.
- Marketplace productivo.
- IA como requisito del producto.

## Regla De Producto

Community debe esconder complejidad, no eliminarla.

El usuario tecnico debe poder llegar rapido al primer resultado, pero FlowOps no debe convertirse en una herramienta no-code generica.

## Estrategia Tecnica

1. Mantener el repo activo intacto durante el laboratorio.
2. Probar empaquetado en `/root/flowops-docker-lab`.
3. Identificar cambios minimos inevitables.
4. Solo despues integrar al repo principal en una rama controlada.

## Criterio De Listo

Community Docker MVP esta listo cuando:

- `docker compose up --build` levanta sin pasos manuales.
- La UI responde en `localhost:5000`.
- Se puede crear o abrir un proyecto.
- Se puede ejecutar un flujo local seguro.
- Los logs aparecen en UI/API.
- Los datos persisten tras reiniciar el contenedor.
- El README permite reproducirlo desde cero.
