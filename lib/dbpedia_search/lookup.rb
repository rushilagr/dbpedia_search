module DbpediaSearch::Lookup 
  require 'dbpedia_search/lookup/results.rb'

  def self.search (text_arr, service)
    results = text_arr.inject(Results.new) do |results, val|
      raw_results = Dbpedia::search(val, method: service)
      results + Results.new(sets: raw_results)
    end
    results.uniq
  end
end
