FROM apache/airflow:2.6.1

# Instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ /opt/airflow/dags/

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Copiar script de inicio
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Usar el punto de entrada personalizado
ENTRYPOINT ["/entrypoint.sh"]

# Usar una variable de entorno para especificar el comando
CMD ["bash", "-c", "exec $AIRFLOW_COMMAND"]