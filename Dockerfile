FROM apache/airflow:2.6.1

# Cambiar a usuario root para tener permisos administrativos
USER root

# Copiar requisitos y instalarlos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ /opt/airflow/dags/

# Copiar script de inicio
COPY entrypoint.sh /entrypoint.sh

# Cambiar permisos del script de inicio
RUN chmod +x /entrypoint.sh

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Volver al usuario airflow
USER airflow

# Usar el punto de entrada personalizado
ENTRYPOINT ["/entrypoint.sh"]

# Usar una variable de entorno para especificar el comando
CMD ["bash", "-c", "exec $AIRFLOW_COMMAND"]