require "httparty"
require "dbpedia"
require "dry-configurable"

require 'dbpedia_search/configuration.rb'
require 'dbpedia_search/dbpedia_gem_extension.rb'
require 'dbpedia_search/spotlight.rb'
require 'dbpedia_search/lookup.rb'

class DbpediaSearch
  def self.search (text, service)
    results = case service
              when :spotlight
                DbpediaSearch::Spotlight.search_spotlight text
              when :keyword
                DbpediaSearch::Lookup.search(text, :keyword)
              when :prefix
                DbpediaSearch::Lookup.search(text, :prefix)
              when :all
                DbpediaSearch.search_all text
              end
    results
  end

  def self.search_all text
    results = DbpediaSearch.search(text, :spotlight).sets + DbpediaSearch.search(text, :keyword) + DbpediaSearch.search(text, :prefix)
    SetCollection.new(set_array:results.uniq)
  end
end