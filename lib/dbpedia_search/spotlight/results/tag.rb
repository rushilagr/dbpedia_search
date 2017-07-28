require 'dbpedia_search/set_collection.rb'

class DbpediaSearch::Spotlight::Results::Tag < DbpediaSearch::SetCollection
  attr_accessor :tag
  def initialize args={}
    args = {tag:''}.merge args
    @tag = args[:tag]
    super
  end

  def hash
    @tag.hash
  end

  def eql?(obj)
    @tag == obj.tag
  end

end