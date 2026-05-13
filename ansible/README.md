# Ansible para Infraestructura

Este directorio contiene la configuración y playbooks de Ansible para la gestión de la infraestructura provisionada con Terraform.

## Estructura recomendada

- `inventories/`: Inventarios por entorno (`dev`, `stage`, `prod`)
- `group_vars/` y `host_vars/`: Variables de grupo y host
- `roles/`: Roles reutilizables (docker, nginx, monitoring, security, etc.)
- `playbooks/`: Playbooks principales (`site.yml`, `validate.yml`)
- `ansible.cfg`: Configuración principal de Ansible

## Flujo recomendado

1. Provisiona la infraestructura con Terraform.
2. Extrae el inventario dinámico de hosts desde los outputs de Terraform.
3. Ejecuta los playbooks de Ansible para configurar los servidores.

## Integración CI/CD

- El pipeline de GitHub Actions debe ejecutar primero Terraform y luego Ansible.
- El inventario de Ansible debe generarse dinámicamente a partir de los outputs de Terraform.
- El microservicio del repo `microservicio` debe desplegarse usando Ansible tras la provisión.
