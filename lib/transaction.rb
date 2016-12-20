require 'date'

class Transaction
    attr_reader: @hash
    attr_reader: @index
    attr_reader: @date
    attr_reader: @inputs
    attr_reader: @outputs

    def initialize(hash, index, date, inputs, outputs)
        @hash = hash
        @index = index
        @date = Time.at(date).to_datetime
        @inputs = inputs
        @outputs = outputs
    end
end
