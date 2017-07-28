module DbpediaSearch::Spotlight
  require 'dbpedia_search/spotlight/results.rb'

  def self.search (text)
    text_hash = {original_text: text, titleized_text: text.split.map(&:capitalize).join(" "), downcased_text: text.downcase}
    results = text_hash.values.inject(Results.new) do |results, str|
      response = get_spotlight_response str
      parsed_response = parse_spotlight_response response
      results.tags |= Results.new(parsed_response: parsed_response).tags
      results
    end
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
     {}
    json = JSON.parse response.body
    keywords = json['annotation']['surfaceForm']
    keywords = [keywords] if keywords.class == {}.class
    return {} if keywords.nil?

    parsed_response = keywords.inject({}) do |parsed_response, keyword|
      sets = keyword['resource']
      sets = [sets] if sets.class == {}.class
      keywords_arr = sets.inject([]) do |keywords_arr, e|
        set_hash = {
          uri:('http://dbpedia.org/resource/' + e["@uri"]), 
          label:e["@label"], 
          score:e["@finalScore"]
        }
        keywords_arr << set_hash
      end
      parsed_response[keyword['@name']] = keywords_arr
      parsed_response
    end

    parsed_response
  end
end