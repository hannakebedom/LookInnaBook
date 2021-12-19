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
            customer = View.create_account
            if create_account(customer)
                if $account.type == "customer"
                    if create_customer(customer)
                        customer_id = get_customer_id
                        if create_customer_account(customer_id, $account.username)
                            customer_main_menu
                        else
                            View.login_error
                            Controller.launch
                        end
                    else
                        View.login_error
                        Controller.launch
                    end
                else
                    if create_owner(customer)
                        owner_id = get_owner_id
                        if create_owner_account(owner_id, $account.username)
                            admin_main_menu
                        else
                            View.login_error
                            Controller.launch
                        end
                    else
                        View.login_error
                        Controller.launch
                    end
                end
            else
                View.login_error
                Controller.launch
            end
        else
            View.quit
        end
    end
end

def login(account) # return boolean (successful or not?) ✅
    puts "Logging in with your account . . .".blue
    $account = account
    if $db.login($account)
        account.type = $db.get_account_type($account)
        puts "Success!".green
        return true
    else
        return false
    end
end

def create_account(customer) # return boolean (successful or not?) ✅
    puts "Creating your account . . .".blue
    $account = Account.new(customer[1].username, customer[1].password, customer[1].type)
    if $db.create_account(customer[1])
        puts "Success!".green
        return true
    else
        return false
    end
end

def create_customer(customer) # ✅
    puts "Creating your customer profile . . .".blue
    if $db.create_customer(customer[0])
        puts "Success!".green
        return true
    else
        return false
    end
end

def create_owner(customer) # ✅
    puts "Creating your admin profile . . .".blue
    if $db.create_owner(customer[0])
        puts "Success!".green
        return true
    else
        return false
    end
end

def get_customer_id # ✅
    return $db.get_customer_id
end

def get_owner_id # ✅
    return $db.get_owner_id
end

def create_customer_account(customer_id, username) # ✅
    if $db.create_customer_account(customer_id, username)
        return true
    else
        View.login_error
        return false
    end
end

def create_owner_account(owner_id, username) # ✅
    if $db.create_owner_account(owner_id, username)
        return true
    else
        View.login_error
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
        if $db.any_items_in_cart?($account.username)
            checkout(View.checkout($db.get_cart_items($account.username)))
        else
            puts "No items in cart. Try searching for books to add to your cart!".red
            customer_main_menu
        end
    else
        View.quit
    end
end

def customer_search_menu(results) # ✅
    choice = View.customer_search_menu
    case choice
    when 1
        # Add book to cart
        add_selected_book(View.get_book_selection(results.ntuples), results)
    when 2
        # View A Book's Details
        get_book_details(View.get_book_details(results.ntuples), results)
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

def get_search_results(query) # ✅
    puts "Getting search results for query '#{query}'".blue
    results = $db.search(query)
    View.search_results(results)
    results.ntuples == 0 ? customer_main_menu : customer_search_menu(results)
end

def get_book_details(index, results)  # ✅
    # get the ith tuple of the query result
    puts "Displaying details of selected book . . .".blue
    View.display_book_details(results[index - 1])
    customer_search_menu(results)
end

def add_selected_book(index, results) # ✅
    puts "Adding selected book to cart . . .".blue
    isbn = results[index[0] - 1]["isbn"].to_i
    quantity = index[1]

    if $db.cart_exists?($account.username)
        cart_id = $db.retrieve_cart($account.username)
        if $db.book_in_cart?(cart_id, isbn)
            puts "Book is already in cart! Book will not be added.".red
        else
            puts "Success!".green
            $db.add_to_cart(cart_id, isbn, quantity)
        end
    else
        $db.create_cart
        cart_id = $db.get_cart_id
        $db.create_manages(cart_id, $account.username)
        if $db.book_in_cart?(cart_id, isbn)
            puts "Book is already in cart! Book will not be added.".red
            customer_search_menu(results)
        else
            puts "Success!".green
            $db.add_to_cart(cart_id, isbn, quantity)
        end
    end
    
    customer_search_menu(results)
end

def get_tracking_info(order_id) # ✅
    puts "Getting tracking information for #{order_id} for user '#{$account.username}' . . .".blue
    if $db.order_exists?(order_id, $account.username)
        View.display_tracking_information(order_id, $db.track_order(order_id))
    else
        puts "Order with order_id: #{order_id} does not exist. Please try again!".red
    end
    
    customer_main_menu
end

def checkout(continue)
    if continue
        $db.place_order
        order_id = $db.get_order_id
        $db.create_places(order_id, $account.username)
        cart_id = $db.retrieve_cart($account.username)
        $db.create_sale(cart_id)
        books = $db.get_books_in_cart(cart_id)
        $db.update_store_quantities(books)
        $db.clear_cart(cart_id)
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
        report_menu
    else
        View.quit
    end
end

def report_menu
    choice = View.report_menu
    case choice
    when 1
        View.sales_by_genre($db.sales_by_genre)
        report_menu
    when 2
        View.sales_by_author($db.sales_by_author)
        report_menu
    when 3
        View.total_sales($db.total_sales)
        report_menu
    else
        admin_main_menu
    end
end

def add_book(book)
    puts "Adding book . . .".blue
    if $db.book_exists?(book.isbn)
        $db.add_existing_book(book.isbn, book.quantity)
    else
        $db.add_new_book(book)
    end
    
    puts "Book successfully added!".green

    admin_main_menu
end

def remove_book(isbn)
    puts "Removing book . . .".blue
    if $db.book_exists?(isbn)
        $db.remove_book(isbn)
        puts "Book successfully removed!".green
    else
        puts "No book with this isbn exists in your store.".red
    end 
    
    admin_main_menu
end