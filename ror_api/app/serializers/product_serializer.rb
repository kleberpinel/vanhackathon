class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url, :price_formated

  def price_formated
    ActionController::Base.helpers.number_to_currency(object.price)   
  end

  def price
    object.price
  end

  def image_url
    turtles_icon = [
      "http://icons.iconarchive.com/icons/icons8/windows-8/512/Cinema-Ninja-Turtle-icon.png",
      "http://www.thinkgeek.com/images/blog/2012pumpkin-20-icon.jpg"
    ]
    if object.image_url == ""
      turtles_icon[rand(0..turtles_icon.size-1)]
    else
      object.image_url
    end
  end
end