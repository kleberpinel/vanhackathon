
desc "Api tasks to generate some fake data"

namespace :generators do

  task :rate => :environment do
    GeneratorService.create_rate_randomicaly
  end

  task :images => :environment do
    GeneratorService.find_products_images
  end

end
