require 'net/https'
require 'date'
require 'json'

require_relative 'block.rb'
require_relative 'transaction.rb'

##
# This class connects to the <code>blockchain.info</code> API to fetch
# data about the blockchain.
#
class BlockchainAPI
    ##
    # The URL of the blockchain.info API.
    #
    @@api_url = "blockchain.info"

    ##
    # In the API, all values are multiplied by this value.
    #
    @@multiplier = 0.00000001

    ##
    # Fetches the last block from the blockchain.
    #
    # @return   A Block containing the requested info
    #
    def latestBlock
        map = JSON.parse(Net::HTTP.get(@@api_url, "/latestblock"))
        Block.new(map["hash"],
                  Time.at(map["time"]).to_datetime,
                  map["txIndexes"])
    end

    ##
    # Fetches the last transactions.
    # What it really does is that it gets all the unconfirmed transactions.
    #
    # @return   A list of the requested Transactions
    #
    def latestTransactions
        map = JSON.parse(Net::HTTP.get(@@api_url, "/unconfirmed-transactions?format=json"))
        map["txs"].map {|hash| parseTransaction(hash)}
    end

    ##
    # Fetches a transaction given by its index.
    #
    # @return   A Transaction containing the requested info
    def transactionByIndex(index)
        begin
            map = JSON.parse(Net::HTTP.get(@@api_url, "/tx-index/#{index}?format=json"))
        rescue
            raise ArgumentError, 'Invalid transaction index'
        end
        parseTransaction(map)
    end

    private
    def parseTransaction(hash)
        inputs = hash["inputs"].map {|inp| inp["prev_out"]["value"] * @@multiplier}
        outputs = hash["out"].map {|out| out["value"] * @@multiplier}
        Transaction.new(hash["hash"],
                        hash["index"],
                        Time.at(hash["time"]).to_datetime,
                        inputs,
                        outputs)
    end
end

if __FILE__ == $0
    api = BlockchainAPI.new
    puts api.latestBlock

    api.latestTransactions.each {|tx| puts tx}

    tx = api.transactionByIndex(200453276)
    puts tx.total_input
    puts tx.total_output
end
