#!/bin/sh
docker exec -it hadoop-namenode /bin/bash -c "hdfs dfs -mkdir -p /logs /jars"
