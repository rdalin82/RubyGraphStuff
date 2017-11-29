require 'pry'
require 'benchmark'
require './edge'
require './graph'
require './prim'
require './prim_heap'


begin
  file = File.open(ARGV[0])
rescue Exception => e
  puts "OOPS - [e.message]"
end

v = file.readline().chomp.to_i || 0
e = file.readline()

g = Graph.new(v)

if file
  until file.eof?
    line = file.readline.chomp
    args = line.split(" ")
    g.add_edge(Edge.new(args[0].to_i, args[1].to_i, args[2].to_f))
  end
else
  puts "You don screwed up"
end

# p = Prim.new(g)
# puts Benchmark.measure { mst = p.run }
p_heap = PrimHeap.new(g)
puts Benchmark.measure { mst_heap = p_heap.run }




# puts mst
# puts p.total_weight

