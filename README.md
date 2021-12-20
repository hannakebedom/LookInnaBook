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
1. Login or create an account

### Customer Functionality
- Search
3. Track an Order
4. 

### Admin Functionality
