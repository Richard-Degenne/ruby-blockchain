class Transaction
    ##
    # Transaction hash, as a string
    #
    attr_reader :hash

    ##
    # Transaction index, as an integer
    #
    attr_reader :index

    ##
    # Transaction date, as a Datetime object
    #
    attr_reader :date

    ##
    # Bitcoin inputs, as an integer list
    #
    attr_reader :inputs

    ##
    # Bitcoin outputs, as an interger list
    #
    attr_reader :outputs

    def initialize(hash, index, date, inputs, outputs)
        @hash = hash
        @index = index
        @date = date
        @inputs = inputs
        @outputs = outputs
    end

    ##
    # Computes the total value of all Bitcoin inputs
    #
    # @return   A float
    #
    def total_input
        @inputs.inject(:+)
    end

    ##
    # Computes the total value of all Bitcoin outputs
    #
    # @return   A float
    #
    def total_output
        @outputs.inject(:+)
    end

    ##
    # Computes the fees paid for the transaction
    #
    # @return   A float
    #
    def fees
        total_input - total_output
    end
end
