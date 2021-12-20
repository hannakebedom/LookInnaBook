# LookInnaBook
Your go-to command-line bookstore. 📚🌱

## Technologies
  - Ruby
  - PostgreSQL

## How to Run the LookInnaBook Command-Line Application
1. Clone this GitHub Repository
2. Make sure you have PostgreSQL installed and configured on your machine.
  You can download it [here](https://www.postgresql.org/download/) if you don't already have it.
3. Create a fresh PostgreSQL database with the name 'bookstore'.  
   - You can do this in PgAdmin or with the command `CREATE DATABASE bookstore`
4. Use the `DDL.sql` file in this repository to create the tables in the bookstore database.
5. Use the `smallRelationsInsertFile.sql` file in this repository to seed the database with some sample data.
6. In the `initialize()` method in the`model.rb` file in the repository change the password to your PostgreSQL password where it says `'insert your password here'`
![intialize method](initialize.png)
7. In the terminal run `bundle install` to install all dependencies required to run this project
8. In the terminal run `rake` to begin using the application.

## How to use LookInnaBook
Login or create an account. Here is the login menu:  
<img width="631" alt="login" src="https://user-images.githubusercontent.com/61071004/146702520-0a922790-57f6-4fb3-8551-3c4413eecfd8.png">

   - Select 1 to login. Feel free to use the accounts below:
     ```
     account 1 (customer account)
     username: cherryIrma
     password: huskyape
     
     account 2 (owner account)
     username: senatorHanna
     password: resistmaterial
     ```
Select 2 to login create an account. Enter the information you are prompted to enter.  
<img width="678" alt="create_account" src="https://user-images.githubusercontent.com/61071004/146702768-16a11320-6806-47d6-b3b0-d24a5cb769f4.png">

  
## Customer Functionality
### Search Books
Enter any search query to explore our collection of books. For example: 
  <img width="734" alt="search" src="https://user-images.githubusercontent.com/61071004/146703097-2cb38312-fd77-4ea3-af59-78aa4a761440.png">    
  After you search for a book, you can add the book to your cart, view more details on it or make another search.  
  Please note that when you select a book you must identify it by the identifying integer on its right hand side wrapped in square brackets. For example:
  <img width="1708" alt="book_details" src="https://user-images.githubusercontent.com/61071004/146703319-38869470-bcca-4a12-8172-b33da2cd1956.png">
### Track an Order
You may track an order by entering the order_id associated with your order.
  <img width="674" alt="track_order" src="https://user-images.githubusercontent.com/61071004/146703613-606d7287-124d-4f1c-84ac-f0f71875f3da.png">
### Checkout
Displays all books in your cart and your purchase information. Prompts you to check out.
<img width="744" alt="checkout" src="https://user-images.githubusercontent.com/61071004/146703900-330e2eac-0ee5-40ab-a76a-037be5d9a710.png">

    
## Admin Functionality
### Add a book
You may add a book to your store's offering by entering the details of the book and the quantity availiable.  
<img width="782" alt="add_book" src="https://user-images.githubusercontent.com/61071004/146704519-b838e832-0190-4bd8-9c09-aa7378f77e96.png">

### Remove a book
You may remove a book to your store's offering by entering the isbn of the book.
<img width="782" alt="remove_book" src="https://user-images.githubusercontent.com/61071004/146704768-badb5b22-df43-49d7-aedd-bf26e4af66a7.png">

### View Reports
When you choose to view reports, you will be met with a report menu. Select the report you would like to view.
Note: These reports are based on a database that has been used for several purchases. To see meaningful reports you will have to buy a few books with the customer account first
<img width="634" alt="report_menu" src="https://user-images.githubusercontent.com/61071004/146704994-6d2c2d42-2214-4ca3-bd90-5eb057222ad1.png">  
For example, here is the report that displays sales by genre.  
<img width="637" alt="sales_by_genre" src="https://user-images.githubusercontent.com/61071004/146705309-cf5898fd-47cd-4c02-885d-67d704fe31b6.png">  
Here is the report that display sales by author.  
<img width="637" alt="sales_by_author" src="https://user-images.githubusercontent.com/61071004/146705460-e63d2a32-9945-444b-87f5-7f41fe74d45e.png">  
Here is the report that displays total sales.  
<img width="637" alt="total_sales" src="https://user-images.githubusercontent.com/61071004/146705602-cd6acdd0-6250-44d9-97ea-73e20d211c9e.png">  





