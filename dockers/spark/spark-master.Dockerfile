FROM spark-base

# -- Runtime

ARG spark_master_web_ui=8080

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1

EXPOSE ${spark_master_web_ui} ${SPARK_MASTER_PORT}
CMD bin/spark-class org.apache.spark.deploy.master.Master