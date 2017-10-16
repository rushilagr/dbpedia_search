require "pp"
require "httparty"
require "dbpedia"
require "dry-configurable"

require 'dbpedia_search/configuration.rb'
require 'dbpedia_search/dbpedia_gem_extension.rb'
require 'dbpedia_search/spotlight.rb'
require 'dbpedia_search/lookup.rb'

class DbpediaSearch
  def self.search (text, service)
    text_arr = pre_process text

    case service
    when :spotlight
      Spotlight.search text_arr
    when :keyword
      Lookup.search(text_arr, :keyword)
    when :prefix
      Lookup.search(text_arr, :prefix)
    when :all
      search_all text_arr
    end
  end

  def self.search_all text_arr
    results = Spotlight.search(text_arr).sets + Lookup.search(text_arr, :keyword) + Lookup.search(text_arr, :prefix)
    results = results.uniq
  end

  def self.pre_process text
    text_hash = {
      original_text: text,
      titleized_text: text.split.map(&:capitalize).join(" "),
      downcased_text: text.downcase
    }
    text_hash.values
  end
end