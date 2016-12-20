class Block
    ##
    # A String identifying the Block
    #
    attr_reader :hash

    ##
    # A Datetime object, denoting the date the block was created
    #
    attr_reader :date

    ##
    # A Transaction list of all the transactions contained in the block
    #
    attr_reader :transactions

    def initialize(hash, date, transactions)
        @hash = hash
        @date = date
        @transactions = transactions
    end
end
