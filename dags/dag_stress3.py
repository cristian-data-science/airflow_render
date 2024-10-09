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
    'light_stress_test_dag',
    default_args=default_args,
    description='A light stress test DAG to avoid crashing the server',
    schedule_interval=None,
    catchup=False
)

# Función que genera una carga de CPU pero no extrema
def light_cpu_stress():
    start_time = time.time()
    while time.time() - start_time < 15:  # Limitar a 15 segundos
        _ = [x**2 for x in range(100000)]  # Proceso moderadamente intensivo en CPU

# Definimos la tarea de Python que ejecuta la función de estrés
stress_task = PythonOperator(
    task_id='light_stress_cpu',
    python_callable=light_cpu_stress,
    dag=dag
)