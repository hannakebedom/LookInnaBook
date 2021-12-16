require_relative 'view'
require_relative 'model'
require_relative 'account'
require 'colorize'

$db = Model.new

class Controller
    def self.launch
        choice = View.welcome
        case choice
        when 1
            if login(View.login)
                $account.type == "customer" ? customer_main_menu : admin_main_menu
            else
                View.login_error
                Controller.launch
            end
        when 2
            if create_account(View.create_account)
                $account.type == "customer" ? customer_main_menu : admin_main_menu
            else
                View.login_error
                Controller.launch
            end
        else
            View.quit
        end
    end
end

def login(account) # return boolean (successful or not?)
    puts "Logging in with your account . . ."
    $account = account
    if $db.login(account.username, account.password)
        puts "Success!".green
        return true
    else
        return false
    end
end

def create_account(customer) # return boolean (successful or not?)
    puts "Creating your account . . ."
    $account = Account.new(customer[1].username, customer[1].password)
    if $db.create_account(customer[1]) && $db.create_customer(customer[0])
        puts "Success!".green
        return true
    else
        return false
    end
end

# CUSTOMER FUNCTIONALITY
def customer_main_menu
    # Add view orders option
    choice = View.customer_main_menu
    case choice
    when 1
        # Search books
        get_search_results(View.search)
    when 2
        # Track an order
        get_tracking_info(View.get_tracking_info)
    when 3
        # Checkout
        checkout(View.checkout($db.get_cart_items($account.username)))
    else
        View.quit
    end
end

def customer_search_menu(query)
    choice = View.customer_search_menu
    case choice
    when 1
        # Add book to cart
        add_selected_book(View.get_book_selection, query)
    when 2
        # View A Book's Details
        get_book_details(View.get_book_details, query)
    when 3
        # Search again
        get_search_results(View.search)
    when 4
        # Go back to main menu
        customer_main_menu
    else
        View.quit
    end
end

def get_search_results(query)
    puts "Getting search results for query '#{query}'".magenta
    View.search_results($db.search(query))
    customer_search_menu(query)
end

def get_book_details(index, query)
    # get the ith tuple of the query result
    puts "Displaying details of selected book . . .".magenta
    View.display_book_details($db.search(query)[index - 1])
    customer_search_menu(query)
end

def add_selected_book(index, query)
    puts "Adding selected book to cart . . .".magenta
    cart_id = $db.retrieve_cart($account.username)
    isbn = $db.search(query)[index[0] - 1]["isbn"].to_i
    quantity = index[1]
    $db.add_to_cart(cart_id, isbn, quantity)
    
    customer_search_menu(query)
end

def get_tracking_info(order_id)
    puts "Getting tracking information for #{order_id} for user '#{$username}' . . ."
    View.display_tracking_information(order_id, $db.track_order(order_id))
    customer_main_menu
end

def checkout(continue)
    if continue
        $db.place_order($account.username)
        $db.record_sale($db.retrieve_cart($account.username))
        # remove quantity from store
        puts "Checked out successfully!".green
        customer_main_menu
    else
        puts "Abandoning checkout . . . ".red
        customer_main_menu
    end
end

# ADMIN FUNCTIONALITY
def admin_main_menu
    # Add view orders option
    choice = View.admin_main_menu
    case choice
    when 1
        # Add book
        add_book(View.add_book)
    when 2
        # Remove book
        remove_book(View.remove_book)
    when 3
        # Display reports
    else
        View.quit
    end
end

def add_book(book)
    puts "ISBN: #{book.isbn}"
    $db.add_book(book)
    admin_main_menu
end

def remove_book(isbn)
    $db.remove_book(isbn)
    admin_main_menu
end