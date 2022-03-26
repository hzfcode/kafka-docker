#!/bin/bash

# while true;do echo 'hello kafka';sleep 3s;done
if [ -z $KAFKA_BROKER_ID ];then
    echo "please input env KAFKA_BROKER_ID"
    exit 1
fi
if [ -z $KAFKA_LOG_DIRS ];then
    echo "please input env KAFKA_LOG_DIRS"
    exit 1
fi
if [ -z $ZOOKEEPER_CONNECT ];then
    echo "please input env ZOOKEEPER_CONNECT"
    exit 1
fi
cd /opt/kafka
sed -i "s/broker.id=0/broker.id=$KAFKA_BROKER_ID/g" config/server.properties
sed -i "s#log.dirs=/tmp/kafka-logs#log.dirs=$KAFKA_LOG_DIRS#g" config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$ZOOKEEPER_CONNECT/g" config/server.properties

bin/kafka-server-start.sh config/server.properties
tail -f logs/controller.log