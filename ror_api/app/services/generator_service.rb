class GeneratorService

  def self.create_rate_randomicaly
    Merchant.all.each do |merchant|
      merchant.update_attributes({
        stars: rand(1..5),
        rate_score: (rand Math::E..Math::PI).round(2)
      })
      merchant.products.each{ |product|
        product.update_attributes({
          price: (rand Math::E..100.99).round(2)
        })
      }
    end
  end

  def self.find_products_images
    Product.all.each{ |product|
      if product.image_url == ""
        name = product.name.split(" ")[0].gsub(/[^0-9A-Za-z]/, '')
        pixabay_wrapper = PixabayWrapper.new
        pixabay_wrapper.find_image(name)
        if !pixabay_wrapper.hits.empty?
          hit = pixabay_wrapper.hit_rand
          product.update_attributes({
            image_url: hit["webformatURL"]
          })
        end
      end
    }
  end
end
