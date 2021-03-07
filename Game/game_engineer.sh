#!/usr/bin/env bash


# Termial display color to keep track
YELLOW='\033[1;33m'
NC='\033[0m'

# Install DBMS PostgreSQL is not already existing
if ! type "psql" > /dev/null; then
	echo -e "${YELLOW}>>> Installing postgresql${NC}"
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
	> /etc/apt/sources.list.d/pgdg.list'
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y install postgresql-13
	echo -e "${YELLOW}>>> $(psql -V) ${NC}"
fi

# Download the data and write it in book.csv
if ! test -f 'book.csv'; then
	echo -e "${YELLOW}>>> Download the data book.csv${NC}"
	curl https://www.usabledatabases.com/database/books-isbn-covers/sample/files/book.csv -o book.csv
fi

# Set authorisation for postgres authentification if necessary
test_output=$(psql -U postgres -c "\l" 2>&1)
error="psql: error: FATAL:  Peer authentication failed for user \"postgres\""
if [ "$test_output" == "$error" ]; then
	echo -e "${YELLOW}>>> Setting authorisation for authentification as postgres user${NC}"
	cur_line="local   all             postgres                                peer"
	new_line="local   all             postgres                                trust"
	sudo sed -i -e "s/$cur_line/$new_line/g" /etc/postgresql/13/main/pg_hba.conf
	sudo service postgresql restart
fi

# Create database and fill with data
echo -e "${YELLOW}>>> Create database${NC}"
db="game_db"
psql -U postgres -c "DROP DATABASE IF EXISTS $db"
psql -U postgres -c "CREATE DATABASE $db"
psql -U postgres -d "$db" -c "
CREATE TABLE masterfile(
		id				INTEGER NOT NULL UNIQUE,
		title			TEXT NOT NULL,
		author			TEXT,
		author_id		INTEGER NOT NULL,
		author_bio		TEXT,
		authors			TEXT,
		title_slug		TEXT,
		author_slug		TEXT,
		isbn13			BIGINT NOT NULL UNIQUE,
		isbn10			TEXT NOT NULL UNIQUE,
		price			TEXT,
		format			TEXT,
		publisher		TEXT,
		pubdate			TEXT,
		edition			TEXT,
		subjects		TEXT,
		lexile			TEXT,
		pages			TEXT,
		dimensions		TEXT,
		overview		TEXT,
		excerpt			TEXT,
		synopsis		TEXT,
		toc				TEXT,
		editorial_reviews	TEXT,

		PRIMARY KEY (isbn13)
);


COPY masterfile 
FROM '$(pwd)/book.csv'
CSV HEADER DELIMITER ',';


CREATE TABLE title (
		id		INTEGER NOT NULL UNIQUE,
		title	TEXT NOT NULL,
		isbn13	BIGINT NOT NULL UNIQUE,

		PRIMARY KEY (isbn13)
);

INSERT INTO title (id, title, isbn13)
SELECT id, title, isbn13 FROM masterfile;	


CREATE TABLE author (
		id		INTEGER NOT NULL UNIQUE,
		author	TEXT,

		PRIMARY KEY (id)
);

INSERT INTO author (id, author)
SELECT id, author FROM masterfile;
"

# Display the database and its tables
psql -U postgres -c "\l $db"
psql -U postgres -d "$db" -c "\dt"