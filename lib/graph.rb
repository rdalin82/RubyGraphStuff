class Graph
  attr_reader :sorted_edges, :v, :e
  def initialize(v)
    @v = v
    @e = 0
    @adj = []
    @v.times { @adj << [] }
  end

  def add_edge(e)
    v = e.either
    w = e.other(v)
    @adj[v].push(e)
    @adj[w].push(e)
    @e += 1
  end

  def edges(v)
    @adj[v].sort if @adj[v]
  end

  def all_edges
    @sorted_edges ||= @adj.flatten.sort
  end
end
