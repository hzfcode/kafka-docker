# kafka

* [github](https://github.com/sharkgulf/kafka-docker)
* [dockerhub](https://hub.docker.com/r/sharkgulf/kafka)

## docker images build

```bash
docker build -t sharkgulf/kafka:1.0.1 .
```

## Create network

```bash
docker network create kafka-net
```

## zookeeper start

```bash
docker run --name zookeeper -d -p 2181:2181 --network=kafka-net zookeeper:3.6.3
```

## kafka cluster start

```bash
for ((i=0;i<3;i++));do
docker run --name kafka-$i \
    -p 909$i:9092 \
    -e HOSTNAME=kafka-$i \
    -e KAFKA_BROKER_ID=$i \
    -e KAFKA_LOG_DIRS=/opt/kafka/kafka-logs \
    -e ZOOKEEPER_CONNECT=zookeeper:2181 \
    -v $PWD/data/$i:/opt/kafka/kafka-logs \
    --network=kafka-net \
    -dit sharkgulf/kafka:1.0.1
done;
```

## kafka cluster stop

```bash
for ((i=0;i<3;i++));do
docker stop kafka-$i
docker rm kafka-$i
done;
```

## kafka quick start

```bash
bin/kafka-server-start.sh config/server.properties
bin/kafka-topics.sh --create --topic foobar --bootstrap-server 127.0.0.1:9092 --partitions 3 --replication-factor 3
bin/kafka-topics.sh --describe --topic foobar --bootstrap-server 127.0.0.1:9092
bin/kafka-topics.sh --delete --topic foobar --bootstrap-server 127.0.0.1:9092
bin/kafka-console-producer.sh --topic foobar --bootstrap-server 127.0.0.1:9092
bin/kafka-console-consumer.sh --topic foobar --from-beginning --bootstrap-server 127.0.0.1:9092
```
