import sys
from confluent_kafka import Consumer, KafkaError
topic = str(sys.argv[1])
print('consuming: ' + topic)
c = Consumer({'group.id': 'mygroup',
              'default.topic.config': {'auto.offset.reset': 'earliest'}})
c.subscribe([topic])
running = True
while running:
  msg = c.poll(timeout=1.0)
  if msg is None: continue
  if not msg.error():
    print('Received message: %s' % msg.value().decode('utf-8'))
  elif msg.error().code() != KafkaError._PARTITION_EOF:
    print(msg.error())
    running = False
c.close()
