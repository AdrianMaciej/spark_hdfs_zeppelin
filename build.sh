# -- Software Stack Version

SPARK_VERSION="3.0.0"
HADOOP_VERSION="2.7"
JUPYTERLAB_VERSION="2.1.5"

# -- Building the Images

docker build \
  -f dockers/base/cluster-base.Dockerfile \
  -t cluster-base .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f dockers/spark/spark-base.Dockerfile \
  -t spark-base .

docker build \
  -f dockers/spark/spark-master.Dockerfile \
  -t spark-master .

docker build \
  -f dockers/spark/spark-worker.Dockerfile \
  -t spark-worker .

docker build \
  -f dockers/spark/spark-submit.Dockerfile \
  -t spark-submit .

docker build \
  -f dockers/spark/spark-history-server.Dockerfile \
  -t spark-history-server .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f dockers/notebooks/jupyterlab.Dockerfile \
  -t jupyterlab .

docker build \
  -f dockers/notebooks/zeppelin.Dockerfile \
  -t zeppelin .
