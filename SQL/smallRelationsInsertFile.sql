delete from account;
delete from author;
delete from bank_account;
delete from book;
delete from cart;
delete from contains;
delete from customer;
delete from customer_account;
delete from genre;
delete from manages;
delete from orders;
delete from owner;
delete from owner_account;
delete from places;
delete from publisher;
delete from publishes;
delete from store;
delete from store_book;
delete from sales;
delete from warehouse;
delete from warehouse_book;
delete from writes;

-- owner of look inna book
insert into owner(name, address) values ('Hanna Kebedom', '450 King St.');

-- look inna book customers
insert into customer(name, address, card_number, email, phone)
values ('Irma A. Deer', '3572 Garafraxa St', '4485 6237 6354 9776', 'IrmaADeer@armyspy.com', '519-706-1224');
insert into customer(name, address, card_number, email, phone)
values ('Zachary D. Holland', '1262 47th Avenue', '4532 8302 4606 9099', 'ZacharyDHolland@rhyta.com', '780-943-2430');
insert into customer(name, address, card_number, email, phone)
values ('Barbara E. Rana', '3699 Tycos Dr', '5409 3018 8882 8892', 'BarbaraERana@rhyta.com', '416-349-5844');

-- look inna book accounts for owner/customers
insert into account values ('senatorHanna', 'resistmaterial', 'owner');
insert into account values ('cherryIrma', 'huskyape', 'customer');
insert into account values ('boyfriendZachary', 'hurrytourist', 'customer');
insert into account values ('BarbaraCroissant', 'creak', 'customer');

-- relationship between accounts and owner/customers
insert into owner_account values ('senatorHanna', 1);
insert into customer_account values ('cherryIrma', 1);
insert into customer_account values ('boyfriendZachary', 2);
insert into customer_account values ('BarbaraCroissant', 3);

-- books
insert into book values (9780744525021, 'Don Quixote', 'The plot revolves around the adventures of a noble (hidalgo) from La Mancha named Alonso Quixano, who reads so many chivalric romances that he loses his mind and decides to become a knight-errant (caballero andante) to revive chivalry and serve his nation, under the name Don Quixote de la Mancha.', 1077, 1605, 18.00);
insert into book values (9780333791035, 'The Great Gatsby', 'The novel tells the tragic story of Jay Gatsby, a self-made millionaire, and his pursuit of Daisy Buchanan, a wealthy young woman whom he loved in his youth.', 152, 1925, 9.89);
insert into book values (9780486280615, 'The Adventures of Huckleberry Finn', 'The novel tells the story of Huckleberry Finns escape from his alcoholic and abusive father and Hucks adventurous journey down the Mississippi River together with the runaway slave Jim.', 366, 1884, 7.87);

-- book genres
-- Don Quixote
insert into genre values ('Parody');
insert into genre values ('Satire');
-- The Great Gatsby
insert into genre values ('Historical Fiction');
insert into genre values ('Tragedy');
-- The Adventures of Huckleberry finn
insert into genre values ('Robinsonade');
insert into genre values ('Adventure');

-- relationship between books and genres
insert into book_genre values (9780744525021, 'Parody');
insert into book_genre values (9780744525021, 'Satire');
insert into book_genre values (9780333791035, 'Historical Fiction');
insert into book_genre values (9780333791035, 'Tragedy');
insert into book_genre values (9780486280615, 'Robinsonade');
insert into book_genre values (9780486280615, 'Adventure');

-- authors
insert into author(name, bio)
values ('Miguel de Cervantes','Miguel de Cervantes, in full Miguel de Cervantes Saavedra, (born September 29?, 1547, Alcalá de Henares, Spain—died April 22, 1616, Madrid), Spanish novelist, playwright, and poet, the creator of Don Quixote (1605, 1615) and the most important and celebrated figure in Spanish literature.');
insert into author(name, bio)
values ('F. Scott Fitzgerald','Scott Fitzgerald, in full Francis Scott Key Fitzgerald, (born September 24, 1896, St. Paul, Minnesota, U.S.—died December 21, 1940, Hollywood, California), American short-story writer and novelist famous for his depictions of the Jazz Age (the 1920s), his most brilliant novel being The Great Gatsby (1925).');
insert into author(name, bio)
values ('Mark Twain','Mark Twain, pseudonym of Samuel Langhorne Clemens, (born November 30, 1835, Florida, Missouri, U.S.—died April 21, 1910, Redding, Connecticut), American humorist, journalist, lecturer, and novelist who acquired international fame for his travel narratives.');

-- relationship between authors and books
insert into writes values (1, 9780744525021);
insert into writes values (2, 9780333791035);
insert into writes values (3, 9780486280615);

-- publishers
insert into publisher(name, address, email, phone, bank_account_no) values ('Penguin Books', '8 Viaduct Gardens, London', 'global@penguinrandomhouse.com', '1-800-733-3000', '4003830171874018');
insert into publisher(name, address, email, phone, bank_account_no) values ('Charles Scribners Sons', '157 Fifth Avenue, New York City', 'publish@scribner.com', '1-800-877-4253', '5496198584584769');
insert into publisher(name, address, email, phone, bank_account_no) values ('Webster and Company', '134 Elloy Avnue, New York City', 'publish@webster.com', '1-800-866-5553', '6011000990139424');

-- relationship between publishers and books
insert into publishes values (1, 9780744525021);
insert into publishes values (2, 9780333791035);
insert into publishes values (3, 9780486280615);

-- bank accounts
insert into bank_account values (4003830171874018, 50000000);
insert into bank_account values (5496198584584769, 30000000);
insert into bank_account values (6011000990139424, 10000000);

-- store
insert into store(name, address) values ('Look Inna Book', '125 Riocan Ave.');

-- books in store (quantity)
insert into store_book(store_id, isbn, quantity) values (1, 9780744525021, 50);
insert into store_book(store_id, isbn, quantity) values (1, 9780333791035, 50);
insert into store_book(store_id, isbn, quantity) values (1, 9780486280615, 50);

-- warehouse
insert into warehouse(address, phone) values ('1 Storage Street', '1-800-936-3574');

insert into warehouse_book(number, isbn, quantity) values (1, 9780744525021, 100);
insert into warehouse_book(number, isbn, quantity) values (1, 9780333791035, 100);
insert into warehouse_book(number, isbn, quantity) values (1, 9780486280615, 100);
