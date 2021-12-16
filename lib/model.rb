#!/usr/bin/ruby

require 'pg'
require_relative 'view'

class Model
    begin
        def initialize()
            @con = PG.connect :dbname => 'bookstore', :user => 'postgres', :password => 'Oranges224'
        end

        def login(username, password)
            rs = @con.exec "SELECT COUNT(*) FROM account WHERE username=\'#{username}\' AND password=\'#{password}\'"
            if rs[0]["count"].to_i > 0
                clear(rs)
                return true
            else
                clear(rs)
                return false
            end
        end

        def create_account(account)
            rs = @con.exec "INSERT INTO account values (\'#{account.username}\',\'#{account.password}\',\'#{account.type}\')"
            if rs.result_status == 1
                clear(rs)
                return true
            else
                clear(rs)
                return false
            end
        end

        def create_customer(customer)
            rs = @con.exec "INSERT INTO customer(name, address, card_number, email, phone) values (\'#{customer.name}\', \'#{customer.address}\', \'#{customer.phone}\', \'#{customer.email}\', \'#{customer.phone}\')"
            if rs.result_status == 1
                clear(rs)
                return true
            else
                clear(rs)
                return false
            end
        end

        def search(title)
            rs = @con.exec "SELECT * FROM book WHERE (lower(title) LIKE lower(\'%#{title}%\'))";
            return rs
        end

        def retrieve_cart(username)
            rs = @con.exec "SELECT cart_id FROM manages WHERE username=\'#{username}\'";
            
            if rs.ntuples > 0
                return rs[0]["cart_id"].to_i
            else
                clear(rs)
                rs = @con.exec "INSERT INTO cart DEFAULT VALUES"
                clear(rs)
                rs = @con.exec "SELECT MAX(cart_id) FROM cart"
                cart_id = rs[0]["max"].to_i
                rs = @con.exec "INSERT INTO manages(cart_id, username) values(#{cart_id}, \'#{username}\')"
                return cart_id
            end
        end

        def add_to_cart(cart_id, isbn, quantity)
            # check that item is not already in cart before trying to insert it
            rs = @con.exec "INSERT INTO contains values (#{cart_id}, #{isbn}, #{quantity})"
            if rs.result_status == 1
                clear(rs)
                return true
            else
                clear(rs)
                return false
            end
        end

        def get_cart_items(username)
            rs = @con.exec "SELECT * FROM (contains natural join manages) natural join book natural join customer_account natural join customer WHERE username=\'#{username}\'"
            return rs
        end

        def place_order(username)
            rs = @con.exec "INSERT INTO orders(order_date, status) values (\'2021-12-15\', \'shipped\')"
            clear(rs)
            rs = @con.exec "SELECT MAX(order_id) FROM orders"
            order_id = rs[0]["max"].to_i
            clear(rs)
            rs = @con.exec "INSERT INTO places(order_id, username) values (\'#{order_id}\',\'#{username}\')"
            clear(rs)
        end

        def record_sale(cart_id)
            rs = @con.exec "INSERT INTO sales(cart_id, isbn, quantity) SELECT * FROM contains WHERE cart_id=\'#{cart_id}\'"
            clear(rs)
            rs = @con.exec "SELECT * FROM contains WHERE cart_id=\'#{cart_id}\'"
            books = []
            quantities = []
            rs.each do |row|
                books << "%s" % [row['isbn']]
                quantities << "%s" % [row['quantity']]
            end
            # update store quantities
            clear(rs)
            books.each do |isbn|
                quantities.each do |quantity|
                    rs = @con.exec "SELECT quantity FROM store_book WHERE store_id = 1 AND isbn=#{isbn}"
                    quantity = quantity.to_i
                    current_quantity = rs[0]["quantity"].to_i
                    clear(rs)
                    rs = @con.exec "UPDATE store_book SET quantity=#{current_quantity-quantity} WHERE store_id = 1 AND isbn=#{isbn}"
                    clear(rs)
                end
            end
            # reset customer's cart
            rs = @con.exec "DELETE FROM contains WHERE cart_id=\'#{cart_id}\'"
            clear(rs)
        end

        def track_order(order_id)
            # returns the status of an order given the order number
            rs = @con.exec "SELECT status FROM orders WHERE order_id = #{order_id}"
            return rs[0]["status"]
        end

        # ADMIN
        def add_book(book)
            # check if book exists in book table
            puts "ISBN: #{book.isbn}"
            rs = @con.exec "SELECT COUNT(*) FROM book WHERE isbn=\'#{book.isbn}\'"
            if rs[0]["count"].to_i == 0
                rs = @con.exec "INSERT INTO book values (#{book.isbn}, \'#{book.title}\', \'#{book.description}\', #{book.pages}, #{book.year}, #{book.price})" 
            end
            clear(rs)
            rs = @con.exec "INSERT INTO store_book values (1, #{book.isbn}, #{book.quantity})"
            clear(rs)
        end

        def remove_book(isbn)
            # removes a book from the books table
            rs = @con.exec "DELETE FROM book WHERE isbn=#{isbn}"
            clear(rs)
        end

        # TEST
        def display_instructors
            rs = @con.exec "SELECT * FROM instructor LIMIT 5"
            rs.each do |row|
                puts "%s %s %s %s" % [ row['id'], row['name'], row['dept_name'], row['salary'] ]
            end
            clear(rs)
        end

        def clear(rs)
            rs.clear if rs
        end

    rescue PG::Error => e
        
        # replace with more generic error eventually
        View.login_error
        puts e.message 
        
    ensure
        @con.close if @con
    end
end