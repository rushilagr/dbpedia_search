# Configure like this
# DbpediaSearch.configure do |config|
#   config.lookup.url = 'Whatever'
# end

class DbpediaSearch
  extend Dry::Configurable
  
  setting :spotlight do
    setting :url, 'http://model.dbpedia-spotlight.org/en/candidates'
    setting :support, 0
    setting :confidence, 0.1
  end
  setting :lookup do
  	setting :url
  end
end
   