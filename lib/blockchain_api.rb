require 'net/https'
require 'date'
require 'json'

require_relative 'block.rb'

class BlockchainAPI
    @@api_url = "blockchain.info"

    def latestBlock
        map = JSON.parse(Net::HTTP.get(@@api_url, "/latestblock"))
        block = Block.new(map["hash"],
                          Time.at(map["time"]).to_datetime,
                          map["txIndexes"])
    end
end

if __FILE__ == $0
    api = BlockchainAPI.new
    puts api.latestBlock
end
