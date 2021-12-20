CREATE TABLE customer
	(customer_id SERIAL,
	 name       varchar(50),
	 address    varchar(50),
     card_number varchar(30),
     email      varchar(50),
     phone      varchar(30),
	 PRIMARY KEY (customer_id)
	);

CREATE TABLE owner
    (owner_id   SERIAL,
	 name       varchar(50),
	 address    varchar(40),
	 PRIMARY KEY (owner_id)
	);

CREATE TABLE account
    (username   varchar(20),
	 password   varchar(20),
	 type       varchar(10),
	 PRIMARY KEY (username)
	);

CREATE TABLE orders
    (order_id   SERIAL,
	 order_date       date,
	 status     varchar(40),
	 PRIMARY KEY (order_id)
	);

CREATE TABLE cart
    (cart_id SERIAL,
	 PRIMARY KEY (cart_id)
	);

CREATE TABLE book
    (isbn bigint UNIQUE,
     title varchar(40),
     description text,
     pages bigint,
     year_published bigint,
     price money,
	 PRIMARY KEY (isbn)
	);

CREATE TABLE genre
    (name varchar(20) UNIQUE,
	 PRIMARY KEY (name)
	);

CREATE TABLE publisher
    (publisher_id SERIAL,
     name varchar(50),
     address varchar(40),
     email varchar(40),
     phone varchar(20),
     bank_account_no varchar(20),
	 PRIMARY KEY (publisher_id)
	);

CREATE TABLE author
    (author_id SERIAL,
     name varchar(50),
     bio text,
	 PRIMARY KEY (author_id)
	);

CREATE TABLE warehouse
    (number SERIAL,
     address varchar(40),
     phone varchar(20),
	 PRIMARY KEY (number)
	);

CREATE TABLE store
    (store_id SERIAL,
     name varchar(50),
     address varchar(40),
	 PRIMARY KEY (store_id)
	);

CREATE TABLE bank_account
    (account_number bigint,
     balance bigint,
	 PRIMARY KEY (account_number)
	);

CREATE TABLE owner_account
    (username varchar(20),
     owner_id bigint,
	 PRIMARY KEY (username),
     FOREIGN KEY (username) references account
		on delete cascade,
     FOREIGN KEY (owner_id) references owner
		on delete cascade
	);

CREATE TABLE customer_account
    (username varchar(20),
     customer_id bigint,
	 PRIMARY KEY (username),
     FOREIGN KEY (username) references account
		on delete cascade,
     FOREIGN KEY (customer_id) references customer
		on delete cascade
	);

CREATE TABLE places
    (order_id    bigint,
     username    varchar(20),
	 PRIMARY KEY (order_id),
     FOREIGN KEY (order_id) references orders
		on delete cascade,
     FOREIGN KEY (username) references account
		on delete cascade
	);

CREATE TABLE manages
    (cart_id    bigint,
     username   varchar(20),
	 PRIMARY KEY (cart_id),
     FOREIGN KEY (cart_id) references cart
		on delete cascade,
     FOREIGN KEY (username) references account
		on delete cascade
	);

CREATE TABLE contains
    (cart_id    bigint,
     isbn       bigint,
     quantity   bigint,  
	 PRIMARY KEY (cart_id, isbn),
     FOREIGN KEY (cart_id) references cart
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE writes
    (author_id  bigint,
     isbn       bigint,
	 PRIMARY KEY (author_id, isbn),
     FOREIGN KEY (author_id) references author
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE publishes
    (publisher_id  bigint,
     isbn          bigint,
	 PRIMARY KEY (publisher_id, isbn),
     FOREIGN KEY (publisher_id) references publisher
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE warehouse_book
    (number  bigint,
     isbn    bigint,
     quantity bigint,
	 PRIMARY KEY (number, isbn),
     FOREIGN KEY (number) references warehouse
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE store_book
    (store_id  bigint,
     isbn      bigint,
     quantity  bigint,
	 PRIMARY KEY (store_id, isbn),
     FOREIGN KEY (store_id) references store
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE book_genre
    (isbn   bigint,
     genre  varchar(20),
	 PRIMARY KEY (genre, isbn),
     FOREIGN KEY (genre) references genre
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE TABLE sales
    (cart_id    bigint,
     isbn       bigint,
     quantity   bigint, 
     date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	 PRIMARY KEY (cart_id, isbn, date),
     FOREIGN KEY (cart_id) references cart
		on delete cascade,
     FOREIGN KEY (isbn) references book
		on delete cascade
	);

CREATE VIEW genre_sales AS
	SELECT genre, COUNT(genre)
	FROM sales natural join book natural join book_genre
	GROUP BY genre;

CREATE VIEW author_sales AS
	SELECT name, COUNT(name)
	FROM sales natural join book natural join (writes natural join author)
	GROUP BY name;

CREATE VIEW total_sales AS
	SELECT SUM(quantity)
	FROM sales;
