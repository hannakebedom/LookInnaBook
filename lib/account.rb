class Account
    attr_accessor :username, :password, :type
    def initialize(username, password, type = "customer")
        @username = username
        @password = password
        @type = type
    end
end