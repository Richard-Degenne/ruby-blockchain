class Transaction
    ## Transaction hash, as a string
    attr_reader :hash

    ## Transaction index, as an integer
    attr_reader :index

    ## Transaction date, as a Datetime object
    attr_reader :date

    ## Bitcoin inputs, as an integer list
    attr_reader :inputs

    ## Bitcoin outputs, as an interger list
    attr_reader :outputs

    def initialize(hash, index, date, inputs, outputs)
        @hash = hash
        @index = index
        @date = date
        @inputs = inputs
        @outputs = outputs
    end

    def total_input
        @inputs.inject(:+)
    end

    def total_output
        @outputs.inject(:+)
    end
end
