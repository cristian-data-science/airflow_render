from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta

# Configuración de argumentos por defecto
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 10, 10),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Definir la función para sumar una lista de números
def sum_numbers():
    numbers = [1, 2, 3, 4, 5]
    total = sum(numbers)
    print(f"La suma de {numbers} es {total}")

# Crear el DAG
with DAG(
    'simple_math_dag',
    default_args=default_args,
    description='Un DAG simple que suma una lista de números',
    schedule_interval=timedelta(days=1),
) as dag:

    # Crear la tarea para ejecutar la suma
    sum_task = PythonOperator(
        task_id='sum_task',
        python_callable=sum_numbers,
    )

    # Definir la secuencia de tareas (en este caso, solo una)
    sum_task