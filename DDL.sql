CREATE TABLE Customer
	(customer_id SERIAL,
	 name       varchar(50),
	 address    varchar(50),
     card_number varchar(30),
     email      varchar(50),
     phone      varchar(30),
	 PRIMARY KEY (customer_id)
	);

CREATE TABLE Owner
    (owner_id   SERIAL,
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

CREATE TABLE Orders
    (order_id   SERIAL,
	 order_date       date,
	 status     varchar(40),
	 PRIMARY KEY (order_id)
	);

CREATE TABLE Cart
    (cart_id SERIAL,
	 PRIMARY KEY (cart_id)
	);

CREATE TABLE Book
    (isbn int UNIQUE,
     title varchar(40),
     description text,
     pages int,
     year_published int,
	 PRIMARY KEY (isbn)
	);

CREATE TABLE Genre
    (name varchar(20) UNIQUE,
	 PRIMARY KEY (name)
	);

CREATE TABLE Publisher
    (publisher_id SERIAL,
     name varchar(50),
     address varchar(40),
     email varchar(20),
     phone varchar(10),
     bank_account_no varchar(10),
	 PRIMARY KEY (publisher_id)
	);

CREATE TABLE Author
    (author_id SERIAL,
     name varchar(50),
     bio text,
	 PRIMARY KEY (author_id)
	);

CREATE TABLE Warehouse
    (number SERIAL,
     address varchar(40),
     phone varchar(10),
	 PRIMARY KEY (number)
	);

CREATE TABLE Store
    (store_id SERIAL,
     name varchar(50),
     address varchar(10),
	 PRIMARY KEY (store_id)
	);

CREATE TABLE Bank_Account
    (account_number SERIAL,
     balance int,
	 PRIMARY KEY (account_number)
	);

CREATE TABLE Owner_Account
    (username varchar(20),
     owner_id int,
	 PRIMARY KEY (username),
     FOREIGN KEY (username) references Account
		on delete cascade,
     FOREIGN KEY (owner_id) references Owners
		on delete cascade
	);

CREATE TABLE Customer_Account
    (username varchar(20),
     customer_id int,
	 PRIMARY KEY (username),
     FOREIGN KEY (username) references Account
		on delete cascade,
     FOREIGN KEY (customer_id) references Customer
		on delete cascade
	);

CREATE TABLE Places
    (order_id    int,
     username    varchar(20),
	 PRIMARY KEY (order_id),
     FOREIGN KEY (order_id) references Orders
		on delete cascade,
     FOREIGN KEY (username) references Account
		on delete cascade
	);

CREATE TABLE Manages
    (cart_id    int,
     username   varchar(20),
	 PRIMARY KEY (cart_id),
     FOREIGN KEY (cart_id) references Cart
		on delete cascade,
     FOREIGN KEY (username) references Account
		on delete cascade
	);

CREATE TABLE Contains
    (cart_id    int,
     isbn       int,
     quantity   int,  
	 PRIMARY KEY (cart_id, isbn),
     FOREIGN KEY (cart_id) references Cart
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);

CREATE TABLE Writes
    (author_id  int,
     isbn       int,
	 PRIMARY KEY (author_id, isbn),
     FOREIGN KEY (author_id) references Author
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);

CREATE TABLE Publishes
    (publisher_id  int,
     isbn          int,
	 PRIMARY KEY (publisher_id, isbn),
     FOREIGN KEY (publisher_id) references Publisher
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);

CREATE TABLE Warehouse_Book
    (number  int,
     isbn    int,
     quantity int,
	 PRIMARY KEY (number, isbn),
     FOREIGN KEY (number) references Warehouse
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);

CREATE TABLE Store_Book
    (store_id  int,
     isbn      int,
     quantity  int,
	 PRIMARY KEY (store_id, isbn),
     FOREIGN KEY (store_id) references Store
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);

CREATE TABLE Book_Genre
    (isbn   int,
     genre  varchar(20) UNIQUE,
	 PRIMARY KEY (genre, isbn),
     FOREIGN KEY (genre) references Genre
		on delete cascade,
     FOREIGN KEY (isbn) references Book
		on delete cascade
	);




















