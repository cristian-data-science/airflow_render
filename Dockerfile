FROM apache/airflow:2.6.1

# Instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ /opt/airflow/dags/

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Usar el punto de entrada predeterminado de Airflow
ENTRYPOINT ["/entrypoint"]

# Usar una variable de entorno para especificar el comando, con un valor predeterminado
CMD ["bash", "-c", "\
    airflow db upgrade && \
    exec airflow webserver --port $PORT"]