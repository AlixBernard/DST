#!/usr/bin/env bash

cDir="$PWD"

v='3.10'
n="apache-cassandra-$v"
f="$n-bin.tar.gz"

cd ~

curl -L -O "http://apache-mirror.rbc.ru/pub/apache/cassandra/$v/$f"
tar -xf "$f"
unlink "./$f"

cd "$n"

cd "$cDir"
