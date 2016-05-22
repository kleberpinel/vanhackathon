class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url, :price_formated

  def price_formated
    ActionController::Base.helpers.number_to_currency(object.price)   
  end

  def price
    object.price
  end
end