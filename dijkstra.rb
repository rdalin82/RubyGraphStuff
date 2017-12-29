require './heap'

class Dijkstra
  attr_reader :dist_to, :edge_to, :edges, :g, :source
  def initialize(g, source)
    @g = g
    @source = source
    @dist_to = Array.new(@g.v) { Float::INFINITY }
    @edge_to = []
    @edges = []
    @visited = Array.new(@g.v)
  end

  def run
    @dist_to[@source] = 0
    @edge_to[@source] = nil
    visit(@source)
    until @edges.empty?
      edge = @edges.shift
      puts edge, @edges.length
      relax(edge)
      visit(edge.other(edge.either)) unless @visited[edge.other(edge.either)]
    end
  end

  def visit(vertex)
    @visited[vertex] = true
    @g.edges(vertex).each do |edge|
      @edges << edge
    end
    @edges.sort
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
    path << stop
    vert = stop
    return path if vert == @source
    path(@edge_to[vert].either, path)
  end
end