require "spec_helper"

describe Product do
  describe "#product" do
    it 'create a product' do
      product = create(:product)

      expect(product).not_to be_nil
    end
  end
end
