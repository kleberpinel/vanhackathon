require "spec_helper"

describe Merchant do
  describe "#merchant" do
    it 'create a merchant' do
      merchant = create(:merchant)

      expect(merchant).not_to be_nil
    end
  end
end
