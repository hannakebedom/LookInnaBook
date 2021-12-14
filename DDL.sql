CREATE TABLE Customer
	(customer_id int AUTO_INCREMENT,
	 name       varchar(50),
	 address    varchar(40),
     card_number varchar(16),
     email      varchar(20),
     phone      varchar(10),
	 PRIMARY KEY (customer_id)
	);

CREATE TABLE Owner
    (owner_id int AUTO_INCREMENT,
	 name       varchar(50),
	 address    varchar(40),
	 PRIMARY KEY (owner_id)
	);

CREATE TABLE Account
    (username   varchar(20),
	 password   varchar(20),
	 type       varchar(10),
	 PRIMARY KEY (username)
	);

CREATE TABLE Owner
    (owner_id int AUTO_INCREMENT,
	 name       varchar(50),
	 address    varchar(40),
	 PRIMARY KEY (owner_id)
	);





