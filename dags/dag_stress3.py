from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
import time

# Definimos los argumentos por defecto
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 10, 9),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,  # Sin reintentos
}

# Definimos el DAG
dag = DAG(
    'simple_stress_test_dag',
    default_args=default_args,
    description='A simple DAG to stress the server without retries',
    schedule_interval=None,
    catchup=False
)

# Función simple que genera una alta carga de CPU
def simple_cpu_stress():
    end_time = time.time() + 30  # Duración de 30 segundos
    while time.time() < end_time:
        _ = [x**2 for x in range(100000)]  # Proceso intensivo en CPU

# Definimos la tarea de Python que ejecuta la función de estrés
stress_task = PythonOperator(
    task_id='simple_stress_cpu',
    python_callable=simple_cpu_stress,
    dag=dag
)