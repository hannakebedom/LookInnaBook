#!/usr/bin/ruby

require 'pg'

class Model
    begin
        def initialize()
            @con = PG.connect :dbname => 'bookstore', :user => 'postgres', :password => 'Oranges224'
        end

        def login(username, password)
            rs = @con.exec "SELECT COUNT(*) FROM account WHERE username=\'#{username}\' AND password=\'#{password}\'"
            if rs[0] == 1
                clear(rs)
                return true
            else
                clear(rs)
                return false
            end
        end

        def create_account(customer)
            
        end

        def search(title, author= nil, isbn = nil, genre = nil)
            # identify all books with the same title, author, isbn or genre
            # display this info on search page

            # returns an array of books that meet criteria
        end

        def book_details(title, author)
            # get the author information, genre, publisher and no. of pages for a specific book

            # returns all info for a particular book
        end

        def registered?(first_name, last_name)
            # determine whether or not a customer is registered
        end

        def register(first_name, last_name, shipping, billing)
            # register a customer for an account before they checkout
        end

        def place_order(customer_id, book_id)
            # place a customers order for a book 
        end

        def track_order(order_num)
            # returns the status of an order given the order number
        end

        # ADMIN
        def add_book(title, author, isbn, genre)
            # adds book to books table
        end

        def remove_book(title, author, isbn)
            # removes a book from the books table
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

        puts e.message 
        
    ensure
        @con.close if @con
    end
end