ARG CONFLUENT_VERSION

FROM confluentinc/cp-kafka-connect-base:${CONFLUENT_VERSION}
LABEL maintainer="code@uweeisele.eu" 

ENV COMPONENT=kafka-connect

USER root

RUN dnf install -y unzip

RUN mkdir -p /var/lib/kafka-connect/ \
    && chown appuser:appuser /var/lib/kafka-connect/
VOLUME ["/var/lib/kafka-connect/"]

USER appuser

RUN mv /etc/confluent/docker/${COMPONENT}.properties.template /etc/confluent/docker/${COMPONENT}-worker.properties.template
COPY include/etc/confluent/docker /etc/confluent/docker

ARG PLUGINS_DIR=/usr/share/confluent-hub-components/
ENV PLUGINS_DIR="${PLUGINS_DIR}"
ENV CONNECT_PLUGIN_PATH=/usr/share/java,${PLUGINS_DIR}
VOLUME ["${PLUGINS_DIR}"]