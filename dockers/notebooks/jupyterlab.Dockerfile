FROM spark-base

# -- Layer: JupyterLab

#ARG spark_version=3.0.0
ARG jupyterlab_version=2.1.5

RUN apt-get update -y && \
    apt-get install -y python3-pip && \
    pip3 install pyspark==${SPARK_VERSION} jupyterlab==${jupyterlab_version}

# -- Runtime

EXPOSE 8888
WORKDIR /jupyterlab
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=