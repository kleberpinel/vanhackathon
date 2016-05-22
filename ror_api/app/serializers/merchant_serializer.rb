class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :street, :city, :category, :latitude, :longitude

  has_many :products
end
