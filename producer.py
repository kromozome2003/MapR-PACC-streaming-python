import sys
from confluent_kafka import Producer
data = sys.argv[1].split(":")
stream = str(data[0])
topic = str(data[1])
print('producing to: ' + stream + ':' + topic)
p = Producer({'streams.producer.default.stream': stream})
some_data_source= ["msg1", "msg2", "msg3"]
for data in some_data_source:
     p.produce(topic, data.encode('utf-8'))
     p.flush()
