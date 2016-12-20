require 'blockchain_api'
require 'block'

RSpec.describe BlockchainAPI, "#latestBlock" do
    context "when connected" do
        it "returns a valid Block" do
            api = BlockchainAPI.new
            block = api.latestBlock

            expect(block.hash).not_to eq ""
            expect(block.transactions).to respond_to("each")
        end
    end
end

RSpec.describe BlockchainAPI, "#latestTransaction" do
    context "when connected" do
        it "returns a valid list of Transactions" do
            api = BlockchainAPI.new
            txs = api.latestTransactions

            expect(txs).to respond_to("each")
        end
    end
end

RSpec.describe BlockchainAPI, "#transactionByIndex" do
    context "with a valid parameter" do
        it "returns a valid Transaction" do
            api = BlockchainAPI.new
            tx = api.transactionByIndex(200453276) # See https://blockchain.info/tx-index/200453276?format=json

            expect(tx.hash).not_to eq ""
            expect(tx.total_input).to eq 0.03178693
            expect(tx.total_output).to eq 0.03138693
        end
    end

    context "with an invalid parameter" do
        it "raises an ArgumentError" do
            api = BlockchainAPI.new
            expect {api.transactionByIndex('invalid_parameter')}.to raise_error(ArgumentError)
        end
    end
end
