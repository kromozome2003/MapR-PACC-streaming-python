# MapR-PACC-streaming-python
## Run PACC w/MapR-ES+POSIX+Python and all libs (Clean)

Assuming your MapR cluster/sandbox is up & running w/IP 192.168.56.101 and you have a valid license for streams

Create sample stream for this demo
```
maprcli stream create -path /mystream -produceperm p -consumeperm p -topicperm p -copyperm p -adminperm p
maprcli stream topic create -path /mystream -topic mytopic
```

## Retrieve this project and build the MapR PACC container
```
git clone https://github.com/kromozome2003/MapR-PACC-streaming-python.git
cd MapR-PACC-streaming-python
wget http://package.mapr.com/releases/installer/mapr-setup.sh
chmod +x mapr-setup.sh
./mapr-setup.sh docker client
```
Respond to the questions as is :
* Image OS class: ubuntu16
* Docker FROM base image name:tag: ubuntu:16.04
* MapR core version: 6.0.1
* MapR MEP version: 5.0.0
* Install Hadoop YARN client: y
* Add POSIX (FUSE) client to container: y
* Add HBase client to container: n
* Add Hive client to container: n
* Add Pig client to container: n
* Add Spark client to container: n
* Add Streams clients to container: y
* MapR client image tag name:  maprtech/pacc:6.0.1_5.0.0_ubuntu16_yarn_fuse_streams
* Container network mode:  bridge
* Container memory: 0
```
docker build -t mapr-pacc-es-client .
vi docker_images/client/mapr-docker-client.sh
```
* set MAPR_CLUSTER to demo.mapr.com
* set MAPR_CLDB_HOSTS to 192.168.56.101:7222
* set MAPR_MOUNT_PATH to /mapr
* set MAPR_CONTAINER_USER to mapr
* set MAPR_CONTAINER_UID to 2000
* set MAPR_CONTAINER_PASSWORD to mapr
* change the last line —> REPLACE maprtech/pacc:6.0.1_5.0.0_ubuntu16_yarn_fuse_streams by mapr-pacc-es-client:latest

## Run the PACC+python+stream container
```
chmod +x docker_images/client/mapr-docker-client.sh
docker_images/client/mapr-docker-client.sh
```
## SSH to your MapR cluster and run the folowing command to monitor the stream messages (built-in java listener)
```
/opt/mapr/kafka/kafka-1.0.1/bin/kafka-console-consumer.sh --new-consumer --bootstrap-server this.will.be.ignored:9092 --topic /mystream:mytopic
```
## Once in the container shell, run the consumer/producer
```
export LD_LIBRARY_PATH=/opt/mapr/lib:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server
python producer.py /mystream:mytopic #You should see new messages (msg1, msg2, msg3) in the MapR cluster terminal
python consumer.py /mystream:mytopic #You should see messages in container console (msg1, msg2, msg3)
```
# Boom ! you are now a MapR-ES (stream) master ;-)
