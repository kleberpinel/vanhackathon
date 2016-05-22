class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url

  def price
    ActionController::Base.helpers.number_to_currency(object.price)   
  end
end