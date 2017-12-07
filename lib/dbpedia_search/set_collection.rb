require 'dbpedia_search/set.rb'

class DbpediaSearch::SetCollection
  include Enumerable
  attr_accessor :sets

  def initialize args={}
    args = {sets:{}}.merge args

    if args[:set_array].nil?
      @sets = args[:sets].map do |set|
        DbpediaSearch::Set.new(
          uri: set[:uri], 
          label: set[:label], 
          score: set[:score]
        )
      end
    else
      #TODO check if array and each element is Set
      @sets = args[:set_array]
    end
  end

  def + given_collection
    new_collection = DbpediaSearch::SetCollection.new
    new_collection.sets = @sets + given_collection.sets
    new_collection
  end

  def each(&block)
    @sets.each(&block)
  end

  def uniq
    new_collection = self.clone
    new_collection.sets = new_collection.sets.uniq
    new_collection
  end

  def filter_using_top_score_multiplier threshold=0
    top_score = self.inject(0) { |top, set| set.score>top ? set.score : top }
    @sets.select { |set| set.score >= (threshold * top_score) }
  end

  def filter_using_absolute_value threshold=0
    @sets.select { |set| set.score >= threshold }
  end
end
