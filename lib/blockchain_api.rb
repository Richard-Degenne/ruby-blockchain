require 'net/https'
require 'date'
require 'json'

require_relative 'block.rb'
require_relative 'transaction.rb'

class BlockchainAPI
    @@api_url = "blockchain.info"

    def latestBlock
        map = JSON.parse(Net::HTTP.get(@@api_url, "/latestblock"))
        Block.new(map["hash"],
                  Time.at(map["time"]).to_datetime,
                  map["txIndexes"])
    end

    def transactionByIndex(index)
        begin
            map = JSON.parse(Net::HTTP.get(@@api_url, "/tx-index/#{index}?format=json"))
            inputs = map["inputs"].map {|inp| inp["prev_out"]["value"]}
            outputs = map["out"].map {|out| out["value"]}
        rescue
            raise ArgumentError, 'Invalid transaction index'
        end
        Transaction.new(map["hash"],
                        map["index"],
                        Time.at(map["time"]).to_datetime,
                        inputs,
                        outputs)
    end
end

if __FILE__ == $0
    api = BlockchainAPI.new
    puts api.latestBlock

    tx = api.transactionByIndex(200453276)
    puts tx.total_input
    puts tx.total_output
end
