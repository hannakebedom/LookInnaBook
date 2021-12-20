require_relative 'account'
require_relative 'customer'
require_relative 'book'
require 'colorize'

# puts String.colors

class View
    def self.welcome
        # welcome page
        num_options = 2
        puts "-------------------------------------------------------------"
        puts "Welcome to Look Inna Book Online Bookshop!".light_green
        puts "To shop with us please choose one of the following options:"
        puts "  (1) Login"
        puts "  (2) Create an account"
        puts "  (0) Quit"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i

        while (choice < 0 || choice > num_options)
            print "Enter your selection: "
            choice = gets.chomp.to_i
        end

        return choice
    end

    def self.login # ✅
        # returns an account(username and password)
        puts "-------------------------------------------------------------"
        puts "Look Inna Book Login Page: "
        print "Username: "
        username = gets.chomp
        print "Password: "
        password = gets.chomp
        puts "-------------------------------------------------------------"
        return Account.new(username, password)
    end

    def self.create_account # returns an array [customer, account(username and password)] ✅
        puts "-------------------------------------------------------------"
        puts "Create an Account (Please fill out the following fields): "
        print "Username: "
        username = gets.chomp
        print "Password: "
        password = gets.chomp
        print "Account Type (\"customer\" or \"owner\"): "
        type = gets.chomp
        while (!(type == "customer" || type == "owner"))
            puts "Invalid Account Type. Account type must be either \"customer\" or \"owner\".".red
            print "Account Type (\"customer\" or \"owner\"): "
            type = gets.chomp
        end
        print "Name: "
        name = gets.chomp
        print "Address: "
        address = gets.chomp
        print "Card Number: "
        card_number = gets.chomp.to_i
        print "Email: "
        email = gets.chomp
        print "Phone: "
        phone = gets.chomp
        puts "-------------------------------------------------------------"
        return [Customer.new(name, address, card_number, email, phone), Account.new(username, password, type)]
    end

    def self.login_error
        puts "-------------------------------------------------------------"
        puts "Login/account creation was unsuccessful, please try again!".red
    end

    # CUSTOMER FUNCTIONALITY
    def self.customer_main_menu # ✅
        num_options = 3
        puts "-------------------------------------------------------------"
        puts "Customer Main Menu: "
        puts "  (1) Search Books"
        puts "  (2) Track an Order"
        puts "  (3) Checkout"
        puts "  (0) Quit"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i
        while (choice < 0 || choice > num_options)
            print "Enter your selection: "
            choice = gets.chomp.to_i
        end

        return choice
    end

    def self.search # ✅
        puts "-------------------------------------------------------------"
        puts "Look Inna Book Search"
        puts "-------------------------------------------------------------"
        print "Enter the title of the book you are searching for: "
        title = gets.chomp
        return title
    end

    def self.search_results(rs) # ✅
        i = 0
        rs.each do |row|
            i += 1
            puts "[#{i}] title: %s, pages: %s, price: %s" % [ row['title'], row['pages'], row['price']]
        end
        if i == 0
            puts "No search results :( ".red
        end
    end

    def self.customer_search_menu
        num_options = 4
        puts "-------------------------------------------------------------"
        puts "  (1) Add a Book to Cart"
        puts "  (2) View A Book's Details"
        puts "  (3) Search Again"
        puts "  (4) Go Back to Main Menu"
        puts "  (0) Quit"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i
        while (choice < 0 || choice > num_options)
            print "Enter your selection: "
            choice = gets.chomp.to_i
        end

        return choice
    end

    def self.get_book_details(num_books)
        puts "-------------------------------------------------------------"
        puts "Which book's details would you like to view? (please enter integer associated with book in search results)"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i
        while choice > num_books || choice <= 0 
            puts "Integer must be less than or equal to #{num_books}. Please try again.".red
            puts "Which book's details would you like to view? "
            choice = gets.chomp.to_i
        end
        return choice
    end

    def self.display_book_details(book)
        puts "-------------------------------------------------------------"
        print "Isbn: ".blue
        puts "#{book["isbn"]}"
        print "Title: ".blue
        puts "#{book["title"]}"
        print "Description: ".blue
        puts book["description"]
        print "Pages: ".blue
        puts book["pages"]
        print "Price: ".blue
        puts book["price"]
        print "Year Published: "
        puts book["year_published"]
    end

    def self.get_tracking_info
        puts "-------------------------------------------------------------"
        print "Enter your order's id: "
        id = gets.chomp.to_i
        return id
    end

    def self.display_tracking_information(order_id, status)
        puts "-------------------------------------------------------------"
        puts "Tracking information for order ##{order_id}:"
        puts "Status: #{status}"
    end

    def self.get_book_selection(num_books)
        puts "-------------------------------------------------------------"
        print "Which book would you like to add to your cart? "
        index = gets.chomp.to_i
        while index > num_books || index <= 0 
            puts "Book id must be less than or equal to #{num_books}. Please try again.".red
            puts "Which book would you like to add to your cart? "
            index = gets.chomp.to_i
        end
        print "How many copies of this book would you like to add to your cart? "
        quantity = gets.chomp.to_i
        return [index, quantity]
    end

    def self.checkout(rs)
        puts "-------------------------------------------------------------"
        puts "Welcome to Look Inna Book Checkout"
        puts "You have the following items in your cart: ".magenta
        i = 0
        subtotal = 0
        card_number = rs[0]['card_number']
        address = rs[0]['address']

        rs.each do |row|
            i += 1
            puts "[#{i}] title: %s, price: %s, quantity: %s".blue % [ row['title'], row['price'], row['quantity']]
        end
        puts "Total Number Items: #{i}"
        puts "Card:               #{card_number}"
        puts "Shipping Address:   #{address}"
        puts "-------------------------------------------------------------"
        puts "Would you like to proceed with this purchase?"
        puts "(1) Yes"
        puts "(2) No"
        print "Enter your selection: "
        response = gets.chomp.to_i
        return response == 1 ? true : false
    end

    # ADMIN FUNCTIONALITY
    def self.admin_main_menu
        num_options = 3
        puts "-------------------------------------------------------------"
        puts "Admin Main Menu: "
        puts "  (1) Add a book"
        puts "  (2) Remove a book"
        puts "  (3) View Reports"
        puts "  (0) Quit"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i
        while (choice < 0 || choice > num_options)
            print "Enter your selection: "
            choice = gets.chomp.to_i
        end

        return choice
    end

    def self.add_book
        puts "-------------------------------------------------------------"
        puts "Please enter the following information about the book you would like to add: "
        print "Isbn: "
        isbn = gets.chomp.to_i
        print "Title: "
        title = gets.chomp
        print "Description: "
        description = gets.chomp
        print "Pages: "
        pages = gets.chomp.to_i
        print "Year Published: "
        year = gets.chomp.to_i
        print "Price: "
        price = gets.chomp.to_i
        print "How many of this book would you like to add?  "
        quantity = gets.chomp.to_i
        while quantity < 0 || quantity > 10
            puts "Please enter a value between 1 and 10".red
            puts "How many of this book would you like to add?  "
            quantity = gets.chomp.to_i
        end
        book = Book.new(isbn, title, description, pages, year, price, quantity)
        return book
    end

    def self.remove_book
        puts "-------------------------------------------------------------"
        print "Please enter the isbn of the book you would like to remove: "
        isbn = gets.chomp.to_i
    end

    def self.report_menu
        num_options = 4
        puts "-------------------------------------------------------------"
        puts "Reports Availiable:"
        puts "  (1) Sales by Genre"
        puts "  (2) Sales by Author"
        puts "  (3) Total Sales"
        puts "  (4) Return to Main Menu"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp.to_i
        while (choice < 0 || choice > num_options)
            print "Enter your selection: "
            choice = gets.chomp.to_i
        end

        return choice
    end

    def self.sales_by_genre(rs)
        puts "-------------------------------------------------------------"
        puts "Sales by genre:"
        rs.each do |row|
            puts "Genre: %s, Books Sold: %s".magenta % [ row['genre'], row['count']]
        end
    end

    def self.sales_by_author(rs)
        puts "-------------------------------------------------------------"
        puts "Sales by author:"
        rs.each do |row|
            puts "Author: %s, Books Sold: %s".magenta % [ row['name'], row['count']]
        end
    end

    def self.total_sales(rs)
        puts "-------------------------------------------------------------"
        puts "Total Sales:"
        rs.each do |row|
            puts "You've sold %s books total.".magenta % [row['sum']]
        end
    end

    def self.quit
        puts "Goodbye! Thanks for shopping with us :)".magenta
    end
end