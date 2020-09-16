FROM spark-base

# -- Runtime

ARG spark_history_server_web_ui=18080
ARG with_hdfs=true

HEALTHCHECK CMD curl -f http://localhost:18080/ || exit 1

ENV SPARK_NO_DAEMONIZE TRUE

EXPOSE ${spark_history_server_web_ui}

CMD ./sbin/start-history-server.sh
