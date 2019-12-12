class Prim
  attr_reader :mst
  def initialize(g)
    @g = g
    @mst = []
    @candidates = []
    @visited = []
    @start = 0
  end

  def run
    visit(@start)
    until @candidates.empty?
      edge =  @candidates.shift
      v = edge.either
      w = edge.other(v)
      next if @visited.include? v and @visited.include? w
      @mst << edge
      visit(v) unless @visited.include? v
      visit(w) unless @visited.include? w
    end
    @mst
  end

  def total_weight
    @mst.map(&:weight).reduce(:+)
  end

  private

  def visit(v)
    @visited << v
    @candidates << @g.edges(v)
    @candidates = @candidates.flatten.sort
  end
end
