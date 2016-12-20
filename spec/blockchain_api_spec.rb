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
