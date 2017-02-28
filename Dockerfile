FROM resin/rpi-raspbian

# TODO
# - now the credentials are set at build time. They should be set at runtime.

# TODO: move to eof
# Expose port for AMQP
EXPOSE 5672
# Expose port for HTTP
EXPOSE 15672
# Expose port for MQTT
EXPOSE 1883


MAINTAINER Heiner Bunjes

# Add files.
ADD bin/* /usr/local/bin/



# WIP
RUN apt-get update            && \
    apt-get install -yqq wget && \
    apt-get install -yqq nano && \ 
    apt-get install -yqq sed 

RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list && \
    wget https://www.rabbitmq.com/rabbitmq-release-signing-key.asc && \
    apt-key add rabbitmq-release-signing-key.asc && \
    apt-get update && \
    apt-get install -yqq rabbitmq-server 

RUN rabbitmq-plugins enable            \
        rabbitmq_management            \
        rabbitmq_mqtt                  \
        rabbitmq_management_visualiser \
        rabbitmq_shovel                \
        rabbitmq_shovel_management && \
    echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
    chmod +x /usr/local/bin/rabbitmq-start 

# Define environment variables.
ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

# Define mount points.
VOLUME ["/data/log", "/data/mnesia"]

# Define working directory.
WORKDIR /data

# Set default user and password
# TODO: Move nearer to begin of file
COPY to-be-copied/rabbitmq.config         /etc/rabbitmq/rabbitmq.config
COPY to-be-copied/rabbitmq.config.example /etc/rabbitmq/rabbitmq.config.example
ARG HB_RABBITMQ_DEFAULT_USER
ARG HB_RABBITMQ_DEFAULT_PASS

RUN echo $HB_RABBITMQ_DEFAULT_USER >  temp.txt
RUN echo $HB_RABBITMQ_DEFAULT_PASS >> temp.txt

RUN sed -i -e "s/<default_user>/$HB_RABBITMQ_DEFAULT_USER/" /etc/rabbitmq/rabbitmq.config
RUN sed -i -e "s/<default_pass>/$HB_RABBITMQ_DEFAULT_PASS/" /etc/rabbitmq/rabbitmq.config


# Define default command.
CMD ["rabbitmq-start"]
