require 'pp'

class DbpediaSearch::Spotlight::Results
  require 'dbpedia_search/spotlight/results/tag.rb'
  include Enumerable
  attr_accessor :tags

  def initialize parsed_response
    @tags = parsed_response.map do |tag, sets|
      Tag.new(tag:tag, sets:sets)
    end
  end

  def each(&block)
    @tags.each(&block)
  end

  def print
    pp self
  end

  def sets
    sets = @tags.inject(Tag.new,:+)
    sets.uniq
  end

  def filter_using_top_score_multiplier threshold=0
    sets = tags.reduce([]) do |sets, tag| 
      sets | tag.filter_using_top_score_multiplier(threshold).sets
    end
  end

  def filter_using_absolute_value threshold=0
    sets = tags.reduce([]) do |sets, tag| 
      sets | tag.filter_using_absolute_value(threshold).sets
    end
  end
end