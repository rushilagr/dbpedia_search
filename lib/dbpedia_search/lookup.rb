module DbpediaSearch::Lookup 
  require 'dbpedia_search/lookup/results.rb'

  def self.search (text, method)
    raw_results = Dbpedia::search(text, method:method)
    Results.new(tag:text, sets:raw_results)
  end
end
