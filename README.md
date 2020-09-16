# Spark HDFS Zeppelin

## Description
Docker images to spin local spark cluster with hdfs nodes and zeppelin attached.

The idea behind this setup was to mimic a spark cluster locally via Docker.

The environment consists of three parts:
 - Spark
 - HDFS
 - Zeppelin / Jupyterlab

Spark cluster can be spin with multiple workers by specifying the scale on the docker-compose command.

HDFS consists of one namenode and one datanode. If you would like to spin more datanodes in your cluster you would need to copy the datanode service multiple time since docker-compose won't allow to automagically create volumes on scaled containers.

Zeppelin for connecting to the cluster and working in a notebook environment. There is also a setup for JupyterLab if the Zeppelin is not working for you.

## How to run it

## Build images
Simply run `./build.sh` which is going to pull:
- openjdk
- bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8
- bde2020/hadoop-datanode:2.0.0-hadoop2.7.4-java8

And then build the following images:
- cluster-base
- spark-base
- spark-master
- spark-worker
- spark-submit
- spark-history-server
- jupyterlab
- zeppelin

### Cluster
* spin standalone cluster: `docker-compose up`
  * with `X` spark workers add: ` --scale spark-worker=X`

spark-history-server is going to fail because at first there won't be `/logs` directory on the hdfs - to fix that, after docker-compose finished run `./init_hdfs_dirs.sh` which is going to initialize the hdfs directories.
Once that is done, spinning the cluster again should make the spark-history-server available.

### Notebook
* spin zeppelin: `docker-compose -f spin_zeppelin.yml up`

or
* spin jupyterlab: `docker-compose -f spin_jupyterlab.yml up`

## Ports
So here is a list of available interface on your localhost once the whole thing works:
| Port      | App                  | Description  |
| --------- |:--------------------:| -----:|
| 8080      | spark-master         | Spark master UI interface |
| 7077      | spark-master         | Spark master port |
| 8081-8087 | spark-worker         | Spark workers UI ports, mapped to internal 8081 - the number depends on the number of workers you are going to spin (max. 7) |
| 9870      | hadoop-namenode      | HDFS file system view |
| 18080     | spark-history-server | Spark history UI where all the apps should be logged in |
| 8888      | jupyterlab           | JupyterLab web app |
| 9090      | zeppelin             | Zeppeling web app |

## Cavients/Problems/ToDos
- Spining up cluster for the first time won't create the directories in hdfs and spark history server is going to crash - probably could be fixed somehow
- From spark master UI you can't dig into workers because it refers to the workers by the internal IP addresses and from localhost we don't have access to that so it won't work - you can either change the url to point to `localhost` and correct `port` (8081-8087) depending on the worker you are trying to connect to.