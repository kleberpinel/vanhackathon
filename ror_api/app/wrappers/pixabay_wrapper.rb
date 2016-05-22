class PixabayWrapper
  attr_accessor :answer
  
  def initialize
    @url = "https://pixabay.com/api/?key=2614199-8667051b6952c194574bdfa73&image_type=photo&pretty=true"
  end

  def find_image(q)
    begin
      url = @url + "#{q}"
      response = HTTParty.get(NormalizeUrl.process(url))
      json = response.body
      @answer = json && json.length >= 2 ? JSON.parse(json) : nil
    rescue => error
      puts error.inspect
    end
  end

  def hits
    @answer["hits"]
  end

  def hit_rand
    hits[rand(0..hits.size-1)]
  end
end
