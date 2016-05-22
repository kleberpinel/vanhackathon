class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :street, :city, :category, :latitude, :longitude, :stars, :rate_score

  has_many :products
end
