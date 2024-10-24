# Proyecto Airflow en Render

Este proyecto implementa un despliegue de **Airflow** utilizando la infraestructura proporcionada por **Render**, enfocado en la gestión de flujos de trabajo automatizados y conectividad con bases de datos. El proyecto está configurado para facilitar la administración de usuarios y garantizar la persistencia del entorno, con énfasis en la interacción con bases de datos externas y conectores relevantes.

## Estructura del Proyecto

### Archivos Clave:
- **Dockerfile**: Define la imagen base y las configuraciones necesarias para instalar Airflow y sus dependencias.
- **entrypoint.sh**: Script de inicialización que:
  - Actualiza la base de datos de Airflow.
  - Crea un usuario administrador si no existe.
  - Ejecuta cualquier comando especificado en la instancia ([ver más](./entrypoint.sh)).

- **requirements.txt**: Lista de dependencias necesarias para la ejecución del proyecto:
  - `psycopg2-binary`: Conexión a PostgreSQL.
  - `redis`: Utilizado para el backend de Airflow.
  - `pandas`, `pyarrow`: Manipulación avanzada de datos.
  - `snowflake-connector-python`: Conector para la integración con Snowflake.
  - `python-dotenv`: Manejo de variables de entorno.
  - `pyodbc`, `pymssql`: Conectores para bases de datos SQL ([ver más](./requirements.txt)).

- **render.yaml**: Archivo de configuración específico para Render, donde se define la infraestructura del servicio, las variables de entorno y los comandos de arranque.

## Funcionamiento del Proyecto

1. **Inicio del Servicio**:
   - Al desplegar en **Render**, se utiliza la configuración del archivo `render.yaml` para iniciar el contenedor.
   - El contenedor ejecuta el script `entrypoint.sh` al inicio para preparar la base de datos y crear el usuario administrador si es necesario.

2. **Ejecución del Script de Entrada (`entrypoint.sh`)**:
   - **Actualización de la Base de Datos**: `airflow db upgrade` garantiza que la estructura de la base de datos esté al día.
   - **Creación del Usuario Administrador**: Si no existe, se crea un usuario con las credenciales definidas en las variables de entorno.
   - **Ejecución del Comando Final**: Se ejecuta cualquier comando especificado en el contenedor, permitiendo la flexibilidad del flujo.

3. **Dependencias**:
   - El archivo `requirements.txt` define todas las librerías necesarias para el funcionamiento del entorno Airflow, así como las conexiones con sistemas externos (bases de datos y Snowflake).

4. **Gestión de Variables de Entorno**:
   - `AIRFLOW_ADMIN_USER` y `AIRFLOW_ADMIN_PASSWORD` se utilizan para definir el usuario administrador al inicio.
   - `python-dotenv` permite gestionar estas variables de manera fácil y segura.

## Despliegue en Render

Para desplegar esta configuración en **Render**:
1. **Subir los archivos necesarios** (`Dockerfile`, `entrypoint.sh`, `render.yaml`, `requirements.txt`).
2. **Configurar las variables de entorno** desde la interfaz de Render, asegurando que estén alineadas con las usadas en `entrypoint.sh`.
3. **Verificar los logs del servicio** para asegurarse de que la base de datos fue actualizada y el usuario fue creado correctamente.

## Uso del Proyecto

- Al acceder a la interfaz de Airflow desplegada, los usuarios pueden:
  - Gestionar **DAGs** (flujos de trabajo).
  - Conectar con bases de datos PostgreSQL, SQL Server o Snowflake mediante los conectores disponibles.
  - Administrar tareas distribuidas usando Redis como backend de almacenamiento.
