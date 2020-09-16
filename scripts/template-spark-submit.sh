docker run --rm -it \
-e SPARK_APPLICATION_MAIN_CLASS="com.example.YourClass" \
-e SPARK_APPLICATION_JAR_LOCATION="hdfs://hadoop-namenode:8020/jars/YourJarFile.jar" \
-e SPARK_APPLICATION_ARGS="" \
-e SPARK_SUBMIT_ARGS="" \
--network spark_hdfs_zeppelin_vpc_network \
spark-submit:latest