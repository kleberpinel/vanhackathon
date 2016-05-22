require 'spec_helper'

describe ImageWorker do
  
#   let!(:merchant) { create(:merchant) }
#   let(:transaction_id) { "1234" }
#   let!(:merchant_api) { create(:merchant_api, active: true, confirmation_flow: "disabled") }
#   let!(:transaction) { create(:transaction, transaction_id: transaction_id, merchant_api: merchant_api)}
#   let!(:fraud_info) { create(:fraud_info, transaction: transaction) }
  
#   context "when merchant api has confirmation_flow disabled" do
#     it "doesn't send any email or SMS" do
#       expect_any_instance_of(FraudInfo).to receive(:generate!)
      
#       delayed = double
#       allow(QuatrroService).to receive(:delay).and_return(delayed)
#       allow(delayed).to receive(:send_transaction).with(transaction.id)
#       expect(MerchantMailer).not_to receive(:send_order_detail_to_consumer)
#       expect(SmsGateway).not_to receive(:send_confirmation_link)
#       GenerateScoreWorker.new.perform(transaction_id)
#     end
#   end
  
end
