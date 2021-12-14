require_relative 'account'
require_relative 'customer'
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

    def self.login
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

    def self.create_account
        # returns an array [customer, account(username and password)]
        puts "-------------------------------------------------------------"
        puts "Create an Account: "
        print "Username: "
        username = gets.chomp
        print "Password: "
        password = gets.chomp
        print "Name: "
        name = gets.chomp
        print "Address: "
        address = gets.chomp
        print "Card Number: "
        card_number = gets.chomp
        print "Email: "
        email = gets.chomp
        print "Phone: "
        phone = gets.chomp
        puts "-------------------------------------------------------------"
        return [Customer.new(name, address, card_number, email, phone), Account.new(username, password)]
    end

    def self.login_error
        puts "Login/account creation was unsuccessful, please try again!"
    end

    def self.customer_main_menu
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

    def self.search
        puts "-------------------------------------------------------------"
        puts "Look Inna Book Search"
        puts "-------------------------------------------------------------"
        print "Enter the title of the book you are searching for: "
        title = gets.chomp
        return title
    end

    def self.search_results(results)
        results.each do |result|
            puts result
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

    def self.get_book_details
        puts "-------------------------------------------------------------"
        puts "Which book's details would you like to view? (please enter integer associated with book in search results)"
        puts "-------------------------------------------------------------"
        print "Enter your selection: "
        choice = gets.chomp
    end

    def self.display_book_details(book)
        puts "-------------------------------------------------------------"
        puts "Book Details"
        puts "Isbn: "
        puts "Title: "
        puts "Description: "
        puts "Pages: "
        puts "Price: "
        puts "Year Published: "
    end

    def self.get_tracking_info
        puts "-------------------------------------------------------------"
        print "Enter your order's id: "
        id = gets.chomp.to_i
        return id
    end

    def self.display_tracking_information(order_id)
        puts "-------------------------------------------------------------"
        puts "Tracking information for order ##{order_id}:"
        puts "Status: Out for delivery"
    end

    def self.get_book_selection
        puts "-------------------------------------------------------------"
        print "Which book would you like to add to your cart?: "
        title = gets.chomp
    end

    def self.checkout(account)
        puts "-------------------------------------------------------------"
        puts "Welcome to Look Inna Book Checkout"
        puts "You have the following items in your cart: "
        puts "No. Items: 3 "
        puts "Subtotal: $67.80 "
        puts "Card: 143091437"
        puts "Shipping Address: 112 Deercroft Avenue"
        puts "-------------------------------------------------------------"
        puts "Would you like to proceed with this purchase?"
        puts "(1) Yes"
        puts "(2) No"
        print "Enter your selection: "
        response = gets.chomp.to_i
        return response == 1 ? true : false
    end

    def self.quit
        puts "Goodbye! Thanks for shopping with us :)".magenta
    end
end