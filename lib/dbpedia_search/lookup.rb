module DbpediaSearch::Lookup 
  require 'dbpedia_search/lookup/results.rb'

  def self.search (text, service)
    # text_hash = {titleized_text: text.split.map(&:capitalize).join(" ")}
    text_hash = {original_text: text, titleized_text: text.split.map(&:capitalize).join(" "), downcased_text: text.downcase}
    results = text_hash.values.inject(Results.new) do |results, val|
      raw_results = Dbpedia::search(text, method: service)
      results + Results.new(sets: raw_results)
    end
    results.uniq
  end
end
