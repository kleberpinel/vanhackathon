FactoryGirl.define do
  factory :merchant do
    name "Merchant #{SecureRandom.uuid}"
    street Faker::Address.street_address
    city Faker::Address.city
    latitude Faker::Number.decimal(2)
    longitude Faker::Number.decimal(2)
    prov "Britsh Columbia"
    category "Bike"
  end
end
