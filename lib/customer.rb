class Customer
    attr_reader :name, :address, :card_number, :email, :phone
    def initialize(name, address, card_number, email, phone)
        @name = name
        @address = address
        @card_number = card_number
        @email = email
        @phone = phone
    end
end