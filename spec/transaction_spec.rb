require 'transaction'
require 'date'

RSpec.describe Transaction, "#total_input" do
    context "with an integer list" do
        it "computes the total input for a given transaction" do
            tx = Transaction.new("57b2bc1d95d46c824e5c4dec1d6a81c8b8e58bcc3fdcd81e546fe24a302c07d1",
                                 200455703,
                                 Time.at(1482230001).to_datetime,
                                 [1000, 2000],
                                 [3000])
            expect(tx.total_input).to eq 3000
        end
    end

    context "with an invalid input list" do
        it "fails with an error" do
            tx = Transaction.new("57b2bc1d95d46c824e5c4dec1d6a81c8b8e58bcc3fdcd81e546fe24a302c07d1",
                                 200455703,
                                 Time.at(1482230001).to_datetime,
                                 [1000, 'invalid_input'],
                                 [3000])
            expect {tx.total_input}.to raise_error(TypeError)
        end
    end
end

RSpec.describe Transaction, "#total_output" do
    context "with an integer list" do
        it "computes the total output for a given transaction" do
            tx = Transaction.new("57b2bc1d95d46c824e5c4dec1d6a81c8b8e58bcc3fdcd81e546fe24a302c07d1",
                                 200455703,
                                 Time.at(1482230001).to_datetime,
                                 [3000],
                                 [1000, 2000])
            expect(tx.total_output).to eq 3000
        end
    end

    context "with an invalid output list" do
        it "fails with an error" do
            tx = Transaction.new("57b2bc1d95d46c824e5c4dec1d6a81c8b8e58bcc3fdcd81e546fe24a302c07d1",
                                 200455703,
                                 Time.at(1482230001).to_datetime,
                                 [3000],
                                 [1000, 'invalid_output'])
            expect {tx.total_output}.to raise_error(TypeError)
        end
    end
end
