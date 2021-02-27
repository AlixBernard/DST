#!/usr/bin/env bash


# Install DBMS PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql

# Set user as postgres, may need to find a different way withour changing user
#sudo -i -u postgres

# Download the data and write it in book.csv
curl https://www.usabledatabases.com/database/books-isbn-covers/sample/files/book.csv -o book.csv

# Need to assign role or sth before continuing
db="game_db"
psql -c "CREATE DATABASE $db"
psql -d $db -c "CREATE TABLE author( author_id serial PRIMARY KEY, author character varying(30), author_bio character varying(200), book_id serial NOT NULL, publisher_id serial NOT NULL)"
psql -d $db -c "\db"
psql -d $db -c "\dt"
psql -d $db -c "\d author"