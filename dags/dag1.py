# create a dag expample
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime

dag = DAG('dag1', description='Simple tutorial DAG',
          schedule_interval='0 12 * * *',
          start_date=datetime(2017, 3, 20), catchup=False)
    
dummy_operator = DummyOperator(task_id='dummy_task', retries=3, dag=dag)
