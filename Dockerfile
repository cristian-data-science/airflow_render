FROM apache/airflow:2.6.1

# Cambiar a usuario root para operaciones privilegiadas
USER root

# Copiar y dar permisos al script de entrada
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Volver al usuario airflow
USER airflow

# Establecer el directorio de trabajo
WORKDIR /opt/airflow

# Copiar e instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar DAGs
COPY dags/ /opt/airflow/dags/

# Usar el punto de entrada personalizado
ENTRYPOINT ["/entrypoint.sh"]