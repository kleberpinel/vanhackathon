class PixabayIntegrator

  def initialize
    @url = "https://pixabay.com/api/?key=2614199-8667051b6952c194574bdfa73&image_type=photo&pretty=true"
  end

  def find_product_image(q)
    url = @url + ""
    response = HTTParty.get(NormalizeUrl.process(url))
    json = response.body
    answer = json && json.length >= 2 ? JSON.parse(json) : nil
  end
end
