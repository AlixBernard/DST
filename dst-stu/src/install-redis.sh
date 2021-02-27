#!/usr/bin/env bash

cDir="$PWD"

v='3.2.8'
n="redis-$v"
f="$n.tar.gz"

cd ~

curl -L -O "http://download.redis.io/releases/$f"
tar -xf "$f"
unlink "./$f"

cd "$n"

make && \
make test && sudo make install

cd "$cDir"



