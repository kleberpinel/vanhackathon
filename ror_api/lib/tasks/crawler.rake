
desc "Api tasks to fetch and save new merchants"

namespace :crawler do

  task :populate_merchant => :environment do
    itens = ["shoes","computers","drinks","bike","toys","house","vegan food", "flip-flops", "chocolate"]
    CrawlerService.new(itens).create_merchant_from_yellow_pages
  end

  task :populate_products => :environment do
    CrawlerService.create_products_randomicaly
  end
end
