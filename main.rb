require 'date'

require_relative 'lib/blockchain_api.rb'

def mean(txs)
    sum = txs.map {|tx| tx.total_input}.inject(:+)
    Float(sum) / txs.size
end

def variance(txs)
    m = mean(txs)
    sum = txs.inject(0) {|acc, i| acc + (i.total_input-m)**2}
end

def standard_deviation(txs)
    Math.sqrt(variance(txs))
end

def btc_format(x)
    format("%.5f", x)
end

puts "Blockchain stats"
puts "================"
puts ""

puts "Unconfirmed transactions"
puts "------------------------"
puts ""

api = BlockchainAPI.new
txs = api.latestTransactions
puts "Sample size:\t #{txs.size} transactions"
puts "Mean value:\t #{btc_format(mean(txs))} BTC"
puts "Standard dev:\t #{btc_format(standard_deviation(txs))}\n"

puts ""
puts "Latest transaction"
puts "------------------\n"
puts ""

tx = txs.sort {|x, y| x.date <=> y.date}[0]
puts "Date:\t #{tx.date}"
puts "Hash:\t #{tx.hash}"
puts "Value:\t #{btc_format(tx.total_input)} BTC"
puts "Fees:\t #{btc_format(tx.fees)} BTC"
