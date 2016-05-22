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
      answer = PixabayIntegrator.new.find_image(name)

      if !answer["hits"].empty?
        hit = answer["hits"][rand(0..answer["hits"].size-1)]
        
        product.update_attributes({
          image_url: hit["webformatURL"]
        })
      end
    }
  end
end
