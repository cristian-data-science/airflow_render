FROM apache/airflow:2.6.1

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Copiar y instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ ./dags/

# Establecer el punto de entrada
ENTRYPOINT ["/entrypoint"]

# Comando de inicio con depuración
CMD ["bash", "-c", "\
    echo 'AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: ' $AIRFLOW__DATABASE__SQL_ALCHEMY_CONN; \
    echo 'AIRFLOW__CORE__SQL_ALCHEMY_CONN: ' $AIRFLOW__CORE__SQL_ALCHEMY_CONN; \
    echo 'DATABASE_URL: ' $DATABASE_URL; \
    airflow db upgrade && \
    airflow users create \
        --username \"$AIRFLOW_ADMIN_USER\" \
        --password \"$AIRFLOW_ADMIN_PASSWORD\" \
        --firstname Admin \
        --lastname User \
        --role Admin \
        --email admin@example.com || true && \
    exec $AIRFLOW_COMMAND"]