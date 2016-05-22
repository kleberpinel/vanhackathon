FactoryGirl.define do
  factory :product do
    name "Product #{SecureRandom.uuid}"
    description Faker::Address.city
    price Faker::Number.decimal(2)
    image_url Faker::Internet.url
  end
end
