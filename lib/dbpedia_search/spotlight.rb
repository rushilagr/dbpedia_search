module DbpediaSearch::Spotlight
  require 'dbpedia_search/spotlight/results.rb'

  def self.search_spotlight (text)
    response = get_spotlight_response text
    parsed_response = parse_spotlight_response response
    results = Results.new(parsed_response)
  end

  def self.get_spotlight_response text
    response = HTTParty.get(
      DbpediaSearch.config.spotlight.url, 
      query: {
        text: text,
        confidence: DbpediaSearch.config.spotlight.confidence,
        support: DbpediaSearch.config.spotlight.support
        },
      headers: {
        'Accept': 'application/json'
        }
      )
    return response
  end

  def self.parse_spotlight_response response
    parsed_response = {}
    json = JSON.parse response.body
    keywords = json['annotation']['surfaceForm']
    keywords = [keywords] if keywords.class == {}.class
    return {} if keywords.nil?

    keywords.each do |keyword|
      keywords_arr = []
      sets = keyword['resource']
      sets = [sets] if sets.class == {}.class

      sets.each do |e|
        set_hash = {
          uri:('http://dbpedia.org/resource/' + e["@uri"]), 
          label:e["@label"], 
          score:e["@finalScore"]
        }
        keywords_arr << set_hash
      end

      parsed_response[keyword['@name']] = keywords_arr
    end
    parsed_response
  end
end