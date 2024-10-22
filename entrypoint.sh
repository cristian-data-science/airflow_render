#!/usr/bin/env bash
# Ejecutar la actualización de la base de datos
airflow db upgrade

# Crear usuario admin si no existe
airflow users create \
  --username "$AIRFLOW_ADMIN_USER" \
  --firstname "Admin" \
  --lastname "User" \
  --role "Admin" \
  --password "$AIRFLOW_ADMIN_PASSWORD" \
  --email "admin@example.com" || true

# Iniciar el scheduler en segundo plano
airflow scheduler &

# Ejecutar el webserver en primer plano
exec airflow webserver

# Ejecutar el comando especificado
exec "$@"