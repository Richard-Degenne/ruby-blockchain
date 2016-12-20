require 'date'

class Block
    attr_reader: @hash
    attr_reader: @date
    attr_reader: @transactions

    def initialize(hash, date, transactions)
        @hash = hash
        @date = Time.at(date).to_datetime
        @transactions = transactions
    end
end
