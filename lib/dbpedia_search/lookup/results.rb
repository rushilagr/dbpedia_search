require 'dbpedia_search/set_collection.rb'

class DbpediaSearch::Lookup::Results < DbpediaSearch::SetCollection
  def initialize args={}
  	args = {sets: {}}.merge args
    args[:sets] = args[:sets].map { |r| {uri: r.uri, label: r.label, score: r.refcount} }
    super
  end
end