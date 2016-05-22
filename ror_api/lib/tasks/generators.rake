
desc "Api tasks to generate some fake data"

namespace :generators do

  task :rate => :environment do
    CrawlerService.create_rate_randomicaly
  end

  task :images => :environment do
    CrawlerService.find_products_images
  end

end
