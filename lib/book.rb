class Book
    attr_reader :isbn, :title, :description, :pages, :year, :price, :quantity
    def initialize(isbn, title, description, pages, year, price, quantity)
        @isbn = isbn
        @title = title
        @description = description
        @pages = pages
        @year = year
        @price = price
        @quantity = quantity
    end
end