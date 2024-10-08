FROM apache/airflow:2.6.1

# Instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ /opt/airflow/dags/

# Establecer variables de entorno
ENV AIRFLOW_HOME=/opt/airflow

# Establecer el directorio de trabajo
WORKDIR $AIRFLOW_HOME

# Configurar el punto de entrada y comando de inicio
ENTRYPOINT ["/entrypoint"]
CMD ["bash", "-c", "airflow db upgrade && \
    airflow users create --username $AIRFLOW_ADMIN_USER --password $AIRFLOW_ADMIN_PASSWORD --firstname Admin --lastname User --role Admin --email admin@example.com && \
    if [ \"$AIRFLOW__CORE__EXECUTOR\" = \"CeleryExecutor\" ]; then \
      airflow celery worker; \
    else \
      airflow scheduler; \
    fi"]