class ImageWorker
  include Sidekiq::Worker
  sidekiq_options(queue: :high_priority, backtrace: true)

  def perform(product_id)
    product = Product.find(product_id)
    name = product.name.split(" ")[0].gsub(/[^0-9A-Za-z]/, '')
    pixabay_wrapper = PixabayWrapper.new
    pixabay_wrapper.find_image(name)
    if pixabay_wrapper.answer.present? && !pixabay_wrapper.hits.empty?
      hit = pixabay_wrapper.hit_rand
      product.update_attributes({
        image_url: hit["webformatURL"]
      })
    end
  end
end
