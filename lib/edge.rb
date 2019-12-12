class Edge
  include Comparable
  attr_accessor :v, :w, :weight

  def initialize(v, w, weight)
    @v = v
    @w = w
    @weight = weight
  end

  def either
    @v
  end

  def other(other)
    return @v if other == @w
    return @w if other == @v
    nil
  end

  def <=>(other)
    weight <=> other.weight
  end

  def to_s
    "start: #{@v} \t\t stop: #{@w} \t\t weight: #{@weight}"
  end
end
