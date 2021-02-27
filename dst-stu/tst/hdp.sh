#!/usr/bin/env bash

#sudo -u hdfs hadoop fs -mkdir /user/hive/warehouse/dst

hadoop fs -mkdir /user/hive/warehouse/dst
hadoop fs -ls /user/hive/warehouse

hadoop fs -copyFromLocal /home/cloudera/dst-stu/d/mr/tf-idf /user/hive/warehouse/dst
hadoop fs -ls /user/hive/warehouse/dst

# run
hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.6.0-mr1-cdh5.10.0.jar \
 -D mapred.reduce.tasks=1 \
 -input /user/hive/warehouse/dst/tf-idf \
 -output /user/hive/warehouse/out \
 -mapper cat \
 -reducer "wc -l"

# check results existence
hadoop fs -ls /user/hive/warehouse/out

# get the result:
hadoop fs -text /user/hive/warehouse/out/part*


