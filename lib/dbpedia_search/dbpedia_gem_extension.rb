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
    var = ::DbpediaSearch.config.lookup.url
    unless var .nil?
      search = {
        'keyword' => var + '/KeywordSearch', 
        'prefix' => var + '/PrefixSearch'
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