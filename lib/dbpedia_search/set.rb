class DbpediaSearch::Set
  attr_accessor :uri, :label, :score

  def initialize args={}
    @uri = args[:uri]
    @label = args[:label]
    @score = args[:score].to_f
  end

  def hash
    @uri.hash
  end

  def eql?(set)
    @uri == set.uri
  end
end
