require 'text/levenshtein'
require 'yaml'

module BK
  # Paul Battley 2007
  # See http://blog.notdot.net/archives/30-Damn-Cool-Algorithms,-Part-1-BK-Trees.html
  # and http://www.dcc.uchile.cl/~gnavarro/ps/spire98.2.ps.gz

  class LevenshteinDistancer
    def call(a, b)
      Text::Levenshtein.distance(a, b)
    end
  end
  
  class HammingDistance
    def call(a,b)
      ai=a.to_i
      bi=b.to_i
      (ai^bi).to_s(2).count("1")
    end
  end

  class Node
    attr_reader :term, :children

    def initialize(term, distancer)
      @term = term
      @children = {}
      @distancer = distancer
    end

    def add(term)
      score = distance(term)
      if child = children[score]
        child.add term
      else
        children[score] = Node.new(term, @distancer)
      end
    end

    def query(term, threshold, collected)
      distance_at_node = distance(term)
      collected[self.term] = distance_at_node if distance_at_node <= threshold
      (-threshold..threshold).each do |d|
        child = children[distance_at_node + d] or next
        child.query term, threshold, collected
      end
    end

    def distance(term)
      @distancer.call term, self.term
    end
  end

  class Tree
    def initialize(distancer = HammingDistance.new)
      @root = nil
      @distancer = distancer
    end

    def add(term)
      if @root
        @root.add term
      else
        @root = Node.new(term, @distancer)
      end
    end

    def query(term, threshold)
      collected = {}
      @root.query term, threshold, collected
      return collected
    end

    def export(stream)
      stream.write YAML.dump(self)
    end
    def export_content
#      YAML.dump(self)
      Marshal.dump(self)
    end

    def self.import(stream)
      YAML.load(stream.read)
    end
    def self.import_content(content)      
#       YAML.load(content)
       Marshal.load(content)
     end
  end
end
