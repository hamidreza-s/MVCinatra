# base controllers
require './controllers/BaseController.rb'

# models
Dir['./models/*.rb'].each do |file|	
  require file
end

# controllers
Dir['./controllers/*.rb'].each do |file|
  require file
end

