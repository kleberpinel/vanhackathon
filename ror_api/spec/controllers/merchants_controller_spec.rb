require 'spec_helper'

describe MerchantsController do
  # before(:each) do
  #   @user = create(:merchant_user)
  #   sign_in @user
  # end

  # context "GET #dashboard" do
  #   before(:each) do
  #     @confirm_orders = []
  #     @unconfirm_orders = []
  #     @cancel_orders = []
  #     @confirm_orders = create_list(:transaction, 3, created_at: 15.days.ago, status: "Confirm")
  #     @unconfirm_orders = create_list(:transaction, 3, created_at: 15.days.ago, status: "Unconfirm")
  #     @cancel_orders = create_list(:transaction, 3, created_at: 15.days.ago, status: "Cancel")
  #   end

  #   it "renders successful response" do
  #     get :dashboard
  #     expect_successful_response
  #     %w(confirm_orders unconfirm_orders cancel_orders).each do |type|
  #       assigns[type.to_sym].each do |order|
  #         expect(instance_variable_get("@#{type}".to_sym)).to include(order)
  #       end
  #     end
  #   end

  #   it "downloads xls if requested" do
  #     get :dashboard, download: "download", order: { created_from: 20.days.ago, created_to: DateTime.now }, api_type: "NMI"
  #     expect_successful_response
  #   end

  #   it "filters based on date" do
  #     get :dashboard, order: { created_from: 1.day.ago, created_to: DateTime.now }
  #     expect(assigns[:confirm_orders]).to be_empty
  #     expect(assigns[:unconfirm_orders]).to be_empty
  #     expect(assigns[:cancel_orders]).to be_empty
  #   end
  # end

  # it "GET #history" do
  #   get :history
  #   expect_successful_response
  # end

  # it "GET #shipping" do
  #   get :shipping
  #   expect_successful_response
  # end

end
