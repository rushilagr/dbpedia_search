module DbpediaGemExtension
  attr_accessor :refcount
  def parse
    self.refcount = read '> Refcount'
    super
  end
end

module Dbpedia
  class SearchResult < Dbpedia::Parser
    prepend DbpediaGemExtension
  end
end

#-------------------------------------------------------------

module DbpediaGemClientExtenstion
  def initialize
    super
    unless DbpediaSearch.config.lookup.url.nil?
      search = {
        'keyword' => DbpediaSearch.config.lookup.url + '/KeywordSearch', 
        'prefix' => DbpediaSearch.config.lookup.url + '/PrefixSearch'
      }
      @uris = {'search' => search}
    end
    @uris
  end
end

module Dbpedia
  class Client
  # class Client < ::DbpediaSearch
    prepend DbpediaGemClientExtenstion
  end
end