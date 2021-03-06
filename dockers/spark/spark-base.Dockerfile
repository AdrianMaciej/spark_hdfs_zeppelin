
FROM cluster-base

# -- Layer: Apache Spark

ARG spark_version=3.0.0
ARG hadoop_version=2.7

RUN apt-get update -y && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    rm spark.tgz

ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_URL spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}
ENV MASTER ${SPARK_MASTER_URL}
ENV PYSPARK_PYTHON python3
ENV SPARK_VERSION ${spark_version}

COPY ./configs/spark/spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf

# -- Runtime

WORKDIR ${SPARK_HOME}