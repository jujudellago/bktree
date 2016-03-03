$:.unshift( File.join( File.dirname(__FILE__), '..', 'lib' ))
require 'bk'

require 'chronic_duration'


#require  File.join( File.dirname(__FILE__), 'utils.rb')
def measure_time(&block)
  t1 = Time.now
  yield
  dt = Time.now - t1 # difference between current time *now* and
  # time that was current before execution of the block
  # which (the difference) means time the block took to run
  return ChronicDuration.output(dt, :format => :short)                           

end



simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + '/export_simhash.yml'))
simhashes=YAML.load(simhashes_dump.read)
ar=simhashes.collect { |k, v| v }.uniq

#numbers=[20,4000,40000,ar.size]
numbers=[20,ar.size]
puts "\n................................................................."
#r = Random.new
trees=[]


numbers.each do |n|
  tree = BK::Tree.new()     

  time=measure_time do 
    n.times do |i|   
      if ar[i]
        nei=ar[i]
      # puts nei #nei=r.rand(1000000000000000000000000000000000000000000000000000000000000...99999999999999999999999999999999999999999999999999999999999999999999999999999)
        tree.add nei unless nei.nil?
      end
    end
     #qs=39647901173536684052513915469162797765845103316861369490934389395352663719681
     #
     #results=tree.query(qs,30)
     #puts "giving #{results.size} results #{results.inspect}" 
    trees<<tree.export_content
  end
  puts "it took #{time} to add #{n} elements to the tree"      
end

puts "\n................................................................."
puts "\n..........Now time for some queries.........................."
trees.each_with_index do |ts,i|
  results=nil
  tree=BK::Tree.import_content(ts)
  time=measure_time do
 #needle=r.rand(1000000000000000000000000000000000000000000000000000000000000...99999999999999999999999999999999999999999999999999999999999999999999999999999)
    #  needle="115792089237316195423570985008687907853269984665640564039457584007913129639935"
    qs=39647901173536684052513915469162797765845103316861369490934389395352663719570

    results=tree.query(qs,30)


  end
  puts "it took #{time} to query ##{i} tree giving #{results.size} results #{results.inspect}" 
end



