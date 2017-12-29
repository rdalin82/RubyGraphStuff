require './heap'

class Dijkstra
  attr_reader :dist_to, :edge_to, :edges, :g, :source
  def initialize(g, source)
    @g = g
    @source = source
    @dist_to = Array.new(@g.v) { Float::INFINITY }
    @edge_to = []
    @edges = Heap.new
    @visited = Array.new(@g.v)
  end

  def run
    @dist_to[@source] = 0
    @edge_to[@source] = nil
    visit(@source)
    until @edges.empty?
      edge = @edges.remove
      relax(edge)
      visit(edge.other(edge.either)) unless @visited[edge.other(edge.either)]
    end
  end

  def visit(vertex)
    @visited[vertex] = true
    @g.edges(vertex).each do |edge|
      @edges.add edge
    end
  end

  def relax(edge)
    start = edge.either
    stop = edge.other(start)
    if (@dist_to[stop] > @dist_to[start] + edge.weight)
      @dist_to[stop] = @dist_to[start] + edge.weight
      @edge_to[stop] = edge
    end
  end

  def path(stop, path=[])
    path.unshift stop
    return path if stop == @source
    path(@edge_to[stop].either, path)
  end
end