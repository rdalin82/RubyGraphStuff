require 'pry'
require 'benchmark'
require './edge'
require './graph'
require './directed_graph'
require './prim'
require './prim_heap'
require './dijkstra'


begin
  file = File.open(ARGV[0])
rescue Exception => e
  puts "OOPS - [e.message]"
end

v = file.readline().chomp.to_i || 0
e = file.readline()
puts "Running prims array and prims heap algo with #{v} verticies and #{e} edges"

g = Graph.new(v)
dg = DirectedGraph.new(v)

if file
  until file.eof?
    line = file.readline.chomp
    args = line.split(" ")
    g.add_edge(Edge.new(args[0].to_i, args[1].to_i, args[2].to_f))
    dg.add_edge(Edge.new(args[0].to_i, args[1].to_i, args[2].to_f))
  end
else
  puts "You don screwed up"
end

p = Prim.new(g)
puts Benchmark.measure { mst = p.run }
p_heap = PrimHeap.new(g)
puts Benchmark.measure { mst_heap = p_heap.run }

d = Dijkstra.new(dg, 0)
d.run

binding.pry
