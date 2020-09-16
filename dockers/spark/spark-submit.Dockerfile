FROM spark-base

# -- Runtime

ENV SPARK_SUBMIT_ARGS=""
ENV SPARK_APPLICATION_ARGS ""
ENV SPARK_DEPLOY_MODE="client"
ENV SPARK_TOTAL_EXEC_CORES=1
ENV SPARK_APPLICATION_JAR_LOCATION="${SPARK_HOME}/examples/jars/spark-examples_2.12-3.0.0.jar"
ENV SPARK_APPLICATION_MAIN_CLASS="org.apache.spark.examples.SparkPi"

CMD ${SPARK_HOME}/bin/spark-submit \
    --class ${SPARK_APPLICATION_MAIN_CLASS} \
    --master ${SPARK_MASTER_URL} \
    --deploy-mode ${SPARK_DEPLOY_MODE} \
    --total-executor-cores ${SPARK_TOTAL_EXEC_CORES} \
    ${SPARK_SUBMIT_ARGS} \
    ${SPARK_APPLICATION_JAR_LOCATION} \
    ${SPARK_APPLICATION_ARGS}
