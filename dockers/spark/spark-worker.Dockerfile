FROM spark-base

# -- Runtime

ARG spark_worker_web_ui=8081

HEALTHCHECK CMD curl -f http://localhost:8081/ || exit 1

EXPOSE ${spark_worker_web_ui}
CMD bin/spark-class org.apache.spark.deploy.worker.Worker ${SPARK_MASTER_URL}