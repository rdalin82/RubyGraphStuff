require 'haversine'
require 'csv'
require 'pry'
require './lib/edge'
require './lib/prim'
require './lib/directed_graph'

class Point
  @@id = 0
  attr_accessor :city, :state, :lat, :long, :i
  def initialize(row)
    @city = row[0]
    @state = row[1]
    @lat = row[2].to_f
    @long = row[3].to_f
    @i = @@id
    @@id += 1
  end

  def to_s
    "#{city} #{state}"
  end

  def to_i
    @i
  end
end

class Traveling
  attr_accessor :max_size, :graph, :prim, :points

  def initialize
    @max_size = 0
    csv = CSV.read('cities.csv')
    length = csv.length
    @points = csv.map do |row|
      Point.new(row)
    end
    @graph = DirectedGraph.new(length)
    edges = []
    cloned_points = @points.clone
    until cloned_points.empty?
      point = cloned_points.pop
      @points.each do |p|
        next if p.lat == point.lat && p.long == point.long
        distance = Haversine.distance(point.lat, point.long, p.lat, p.long).to_miles
        edges << Edge.new(point.to_i, p.to_i, distance)
      end
    end
    edges.each do |e|
      @graph.add_edge(e)
    end
    run
  end

  def run
    generate_prim
  end

  def generate_prim
    @prim = Prim.new(@graph)
    @prim.run
    @max_size = prim.total_weight
  end

  def mst
    @prim.mst
  end

  def close_tree
    firstV = points.find { |p| p.i == mst.first.v }
    firstW = points.find { |p| p.i == mst.first.w }
    lastV = points.find { |p| p.i == mst.last.v }
    lastW = points.find { |p| p.i == mst.last.w }

    distances = []

    distances << [Haversine.distance(firstV.lat, firstV.long, lastV.lat, lastV.long).to_miles, firstV, lastV]
    distances << [Haversine.distance(firstW.lat, firstW.long, lastW.lat, lastW.long).to_miles, firstW, lastW]
    distances << [Haversine.distance(firstW.lat, firstW.long, lastV.lat, lastV.long).to_miles, firstW, lastV]
    distances << [Haversine.distance(firstV.lat, firstV.long, lastW.lat, lastW.long).to_miles, firstV, lastW]
    candidate = distances.sort_by { |d| d[0] }.shift
    edges = @prim.mst.clone
    edges << Edge.new(candidate[1].to_i, candidate[2].to_i, candidate[0])
  end

  def print_path
    close_tree.map do |edge|
      v, w = edge.v, edge.w
      point1 = points.find { |p| p.i == v }
      point2 = points.find { |p| p.i == w }
      puts "#{point1} to #{point2}, then \n"
    end
  end

  def close_tree_weight
    close_tree.map(&:weight).reduce(:+)
  end
end

t = Traveling.new

puts "prim x2 is #{t.max_size*2}"
puts "traveling santa is #{t.close_tree_weight}"
puts "path is"
t.print_path.inspect


edges = t.close_tree
acc = []
acc << edges.shift
until edges.empty?
  edge = edges.shift
  next unless acc.last.w == edge.v
  acc << edge
end
visted = acc.map(&:v)
puts "Wippppp"
binding.pry


