# DST
Data Storage Technologies course


## Tasks

- Task 1: dst-stu/src/1/  
- Redis: redis/
- OrientDB:
	- orientdb_task.txt
	- cf. notes.pdf for install and details
- Hadoop task:
	- mapper.sh
	- reducer.sh
	- hadoop_task.mp4
	```bash
	docker pull cloudera/quickstart:latest
	docker run -m 6G --memory-reservation 2G --memory-swap 8G --hostname=quickstart.cloudera --privileged=true -t -i -v $(pwd):/alix --publish-all=true -p8888 -p8088 cloudera/quickstart /usr/bin/docker-quickstart

	# The following is to type inside the container cli
	hadoop fs -copyFromLocal /alix/DST /user/root/DST
	hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.6.0-mr1-cdh5.7.0.jar \
	    -D mapred.reduce.tasks=1 \
	    -input /user/root/DST/dst-stu/d/mr/tf-idf \
	    -output /user/root/DST/output \
	    -mapper /alix/DST/mapper.sh \
	    -reducer /alix/DST/reducer.sh
	hadoop fs -cat /user/root/DST/output/part*
	#hadoop fs -rm -r /user/root/DST/output
	```


## Presentations

- Lucene Spatial Index: Lucene_Spatial_Index/lucene_spatial_index.pds
- Apache Mahout: Mahout/mahout.pdf