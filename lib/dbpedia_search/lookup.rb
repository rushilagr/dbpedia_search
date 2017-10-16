module DbpediaSearch::Lookup 
  require 'dbpedia_search/lookup/results.rb'

  def self.search (text_arr, service)
    results = text_arr.each_with_object(Results.new) do |val, results|
      raw_results = Dbpedia::search(val, method: service)
      results += Results.new(sets: raw_results)
    end
    results.uniq
  end
end
