class CrawlerService

  def initialize(itens_to_index)
    @itens_to_index = itens_to_index
  end

  def create_merchant_from_yellow_pages
    @itens_to_index.each do |iten|
      sleep(2.seconds)
      url = "http://api.sandbox.yellowapi.com/FindBusiness/?what=#{iten}&where=Vancouver&pg=1&dist=1&fmt=JSON&lang=en&UID=mg5twsw7yws8tbupev6vhad2&apikey=mg5twsw7yws8tbupev6vhad2"
      # url = "http://api.yellowapi.com/FindBusiness/?what=shoes&where=Vancouver&pgLen=5&pg=1&dist=1&fmt=JSON&lang=en&UID=6h6zy72hrz6wcsmubmpzv7yn&apikey=6h6zy72hrz6wcsmubmpzv7yn"

      response = HTTParty.get(url)
      puts "-- #{response.body}"
      answer = JSON.parse(response.body)
      answer["listings"].each{ | store |
        address = store["address"]
        geoCode = store["geoCode"]
        params = {
          name: store["name"],
          street: address["street"],
          city: address["city"],
          prov: address["prov"],
          pcode: address["pcode"]
        }

        if geoCode.present?
          params[:latitude] = geoCode["latitude"]
          params[:longitude] = geoCode["longitude"]
        end

        Merchant.where(params).first_or_create
      }
      sleep(2.seconds)
    end
  end
end
