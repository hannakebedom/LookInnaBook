class Account
    attr_reader :username, :password, :type
    def initialize(username, password, type = "")
        @username = username
        @password = password
        @type = type
    end
end