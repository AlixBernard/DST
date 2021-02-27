-- first you need to create `client` and `car` tables and then import the data

-- defining schema

create table `model` {
	model_id     int(16)      serial,
	brand_id     int(16)      not null,
	name         varchar(128) not null,
	drive        varchar(128),
	transmission varchar(128),
	cityMPG      float(8),
	highwayMPG   float(8),
	primary key (model_id)
};

create table `brand` {
	brand_id     int(16) serial,
	name         varchar(128) not null,
	primary key (brand_id)
};

create table `rent` {
	date_since datetime     not null default '0000-00-00',
	date_till  datetime     not null default '0000-00-00',
	vin        varchar(128) not null,
	client_id  int(16)      not null,
  sum        float(8)     not null default 0.0,
	primary key (date_since, date_till, vin)
};

-- defining data
