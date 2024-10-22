FROM apache/airflow:2.7.3

# Cambiar a usuario root para operaciones privilegiadas
USER root

# Copiar script de entrada y cambiar permisos
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Cambiar a usuario airflow para instalar dependencias
USER airflow

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Copiar y instalar requisitos como usuario airflow
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs como usuario airflow
COPY dags/ /opt/airflow/dags/

# Usar el punto de entrada personalizado
ENTRYPOINT ["/entrypoint.sh"]