#!/usr/bin/ruby

require 'pg'
require_relative 'view'
require 'colorize'
require 'date'

class Model
    begin
        def initialize()
            @con = PG.connect :dbname => 'bookstore', :user => 'postgres', :password => 'Oranges224'
        end

        def login(account) #boolean ✅
            return account_exists?(account)
        end

        def account_exists?(account) #boolean ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM account WHERE username=\'#{account.username}\' AND password=\'#{account.password}\'"
                if rs[0]["count"].to_i > 0
                    clear(rs)
                    return true
                else
                    clear(rs)
                    return false
                end
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again.".red
                return false
            end
        end

        def get_account_type(account) #string ("customer" or "owner") ✅
            begin
                rs = @con.exec "SELECT type FROM account WHERE username=\'#{account.username}\' AND password=\'#{account.password}\'"
                return rs[0]["type"]
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def create_account(account) #boolean ✅
            return false if account_exists?(account)
            begin
                rs = @con.exec "INSERT INTO account values (\'#{account.username}\',\'#{account.password}\',\'#{account.type}\')"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_customer(customer) #boolean ✅
            begin
                rs = @con.exec "INSERT INTO customer(name, address, card_number, email, phone) values (\'#{customer.name}\', \'#{customer.address}\', \'#{customer.phone}\', \'#{customer.email}\', \'#{customer.phone}\')"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_owner(customer) #boolean ✅
            begin
                rs = @con.exec "INSERT INTO owner(name, address) values (\'#{customer.name}\', \'#{customer.address}\')"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def get_customer_id #integer ✅
            begin
                rs = @con.exec "SELECT MAX(customer_id) FROM customer"
                customer_id = rs[0]["max"].to_i
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def get_owner_id #integer ✅
            begin
                rs = @con.exec "SELECT MAX(owner_id) FROM owner"
                owner_id = rs[0]["max"].to_i
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end
        
        def create_customer_account(customer_id, username) #boolean ✅
            begin
                rs = @con.exec "INSERT INTO customer_account values (\'#{username}\', #{customer_id})"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_owner_account(owner_id, username) #boolean ✅
            begin
                rs = @con.exec "INSERT INTO owner_account values (\'#{username}\', #{owner_id})"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def search(title) # query result ✅
            begin
                rs = @con.exec "SELECT * FROM book WHERE (lower(title) LIKE lower(\'%#{title}%\'))";
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end


        def cart_exists?(username) # ✅
            begin
                rs = @con.exec "SELECT COUNT(cart_id) FROM manages WHERE username=\'#{username}\'";
                rs[0]["count"].to_i > 0 ? true : false
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def retrieve_cart(username) # ✅
            begin
                rs = @con.exec "SELECT cart_id FROM manages WHERE username=\'#{username}\'";
                return rs[0]["cart_id"].to_i
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def create_cart # ✅
            begin
                rs = @con.exec "INSERT INTO cart DEFAULT VALUES"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end
        
        def get_cart_id # ✅
            begin
                rs = @con.exec "SELECT MAX(cart_id) FROM cart"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_manages(cart_id, username) # ✅
            begin
                rs = @con.exec "INSERT INTO manages(cart_id, username) values(#{cart_id}, \'#{username}\')"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def book_in_cart?(cart_id, isbn) # ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM contains WHERE cart_id=#{cart_id} AND isbn=#{isbn}"
                if rs[0]["count"].to_i > 0
                    return true
                else
                    return false
                end
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def add_to_cart(cart_id, isbn, quantity) # ✅
            begin
                rs = @con.exec "INSERT INTO contains values (#{cart_id}, #{isbn}, #{quantity})"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def any_items_in_cart?(username) # ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM (contains natural join manages) natural join book natural join customer_account natural join customer WHERE username=\'#{username}\'"
                rs[0]["count"].to_i > 0 ? true : false
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end
        
        def get_cart_items(username) # ✅
            begin
                rs = @con.exec "SELECT * FROM (contains natural join manages) natural join book natural join customer_account natural join customer WHERE username=\'#{username}\'"
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def place_order # ✅
            begin
                date = DateTime.now
                rs = @con.exec "INSERT INTO orders(order_date, status) values (\'#{date.strftime("%Y-%m-%d")}\', \'shipped\')"
                return true 
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def get_order_id # ✅
            begin
                rs = @con.exec "SELECT MAX(order_id) FROM orders"
                return rs[0]["max"].to_i
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_places(order_id, username) # ✅
            begin
                rs = @con.exec "INSERT INTO places(order_id, username) values (#{order_id},\'#{username}\')"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def create_sale(cart_id) # ✅
            begin
                rs = @con.exec "INSERT INTO sales(cart_id, isbn, quantity) SELECT * FROM contains WHERE cart_id=\'#{cart_id}\'"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def get_books_in_cart(cart_id) # ✅
            begin
                rs = @con.exec "SELECT * FROM contains WHERE cart_id=\'#{cart_id}\'"
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def clear_cart(cart_id) # ✅
            begin
                rs = @con.exec "DELETE FROM contains WHERE cart_id=\'#{cart_id}\'"
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def get_current_store_book_quantity(isbn) # ✅
            begin
                rs = @con.exec "SELECT quantity FROM store_book WHERE store_id = 1 AND isbn=#{isbn}"
                return rs[0]["quantity"].to_i
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def update_store_book_quantity(quantity, isbn) # ✅
            begin
                rs = @con.exec "UPDATE store_book SET quantity=#{quantity} WHERE store_id = 1 AND isbn=#{isbn}"
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def update_store_quantities(rs) # ✅
            begin
                books = []
                quantities = []
                rs.each do |row|
                    books << "%s" % [row['isbn']]
                    quantities << "%s" % [row['quantity']]
                end
                clear(rs)
                books.each do |isbn|
                    quantities.each do |quantity|
                        current_quantity = get_current_store_book_quantity(isbn)
                        q = current_quantity - quantity.to_i
                        q = 0 if q < 0
                        clear(rs)
                        update_store_book_quantity(q, isbn)
                        clear(rs)
                    end
                end
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def order_exists?(order_id, username) # ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM orders WHERE order_id = #{order_id}"
                rs[0]["count"].to_i > 0 ? true : false
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end
        
        def track_order(order_id) # ✅
            begin
                rs = @con.exec "SELECT status FROM orders WHERE order_id = #{order_id}"
                return rs[0]["status"]
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        # ADMIN
        def book_exists?(isbn) # ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM book WHERE isbn=\'#{isbn}\'"
                rs[0]["count"].to_i == 0 ? false : true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def add_new_book(book) # ✅
            begin
                rs = @con.exec "INSERT INTO book values (#{book.isbn}, \'#{book.title}\', \'#{book.description}\', #{book.pages}, #{book.year}, #{book.price})" 
                rs = @con.exec "INSERT INTO store_book values (1, #{book.isbn}, #{book.quantity})"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def add_existing_book(isbn, quantity) # ✅
            begin
                rs = @con.exec "UPDATE store_book set quantity=quantity + #{quantity} WHERE isbn=#{isbn}"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def book_exists?(isbn) # ✅
            begin
                rs = @con.exec "SELECT COUNT(*) FROM book WHERE isbn=#{isbn}"
                rs[0]["count"].to_i > 0 ? true : false
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def remove_book(isbn) # ✅
            begin
                rs = @con.exec "DELETE FROM book WHERE isbn=#{isbn}"
                rs = @con.exec "DELETE FROM store_book WHERE isbn=#{isbn}"
                return true
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
                return false
            end
        end

        def sales_by_genre
            begin
                rs = @con.exec "SELECT * from genre_sales"
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def sales_by_author
            begin
                rs = @con.exec "SELECT * from author_sales"
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def total_sales
            begin
                rs = @con.exec "SELECT * from total_sales"
                return rs
            rescue => exception
                puts "Oh no! An error occurred when accessing the database, please try again!".red
            end
        end

        def clear(rs)
            rs.clear if rs
        end

    rescue PG::Error => e
        
        # replace with more generic error eventually
        puts e.message 
        
    ensure
        @con.close if @con
    end
end