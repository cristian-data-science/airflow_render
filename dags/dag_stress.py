from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import multiprocessing
import time

# Definimos el DAG con sus argumentos
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 10, 9),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Definimos el DAG
dag = DAG(
    'stress_test_dag',
    default_args=default_args,
    description='A simple DAG to stress the server',
    schedule_interval=None,
    catchup=False
)

# Función que estresa el servidor
def cpu_stress():
    def stress_test():
        # Tarea que consume CPU por unos 30 segundos
        end_time = time.time() + 30  # 30 segundos
        while time.time() < end_time:
            _ = [x**2 for x in range(100000)]  # Proceso intensivo en CPU

    # Usamos varios procesos para aumentar la carga
    processes = []
    for _ in range(multiprocessing.cpu_count()):
        p = multiprocessing.Process(target=stress_test)
        p.start()
        processes.append(p)

    for p in processes:
        p.join()

# Creamos una tarea de Python que ejecuta la función de estrés
stress_task = PythonOperator(
    task_id='stress_cpu',
    python_callable=cpu_stress,
    dag=dag
)