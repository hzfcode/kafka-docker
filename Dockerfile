FROM openjdk:17.0.2

# install kafka
ARG KAFKA_VERSION=kafka_2.12-3.1.0
RUN curl -o /tmp/${KAFKA_VERSION}.tgz https://dlcdn.apache.org/kafka/3.1.0/${KAFKA_VERSION}.tgz

RUN ls /tmp && tar xfz /tmp/${KAFKA_VERSION}.tgz -C /opt && \
    mv /opt/${KAFKA_VERSION} /opt/kafka && \
    rm /tmp/${KAFKA_VERSION}.tgz

EXPOSE 9092

COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]