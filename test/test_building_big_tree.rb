require 'common'
require 'bk'
require 'bk/dump'

class BKTreeBuildingBigWhiteBoxTest < Test::Unit::TestCase
  attr_reader :tree

  ID_SUB=1953531228
  #NEEDLE_64=12136637984131628975  # uniq
  NEEDLE_64=12136637984131628975   # no uniq

  #NEEDLE_128=107099746862951634459636923951664610746
  NEEDLE_128=107099746862951634459636923951664610746
  
 # NEEDLE_256=13305273546159547682797617048043439
  NEEDLE_256=109062172162421398478269738549435119672348622091890704283604517451031691673018

  NEEDLE_RUBY_128=132922799578588603592670086706096301231


  NEEDLE_RUBY_256=35330404686073069456366885364891883111867723788620996212239170045159838296865
  #35330404672593096122791565467558375579246944192638629531682756541675727465249  

  DISTANCE=15
  VARIATION="_no_uniq"
  def setup
    @tree = BK::Tree.new()


  end

  def test_should_find_matching_64
    puts "\n\ntest_should_find_matching_64"    
    simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/export_simhash_64#{VARIATION}.yml"))
    simhashes=YAML.load(simhashes_dump.read)
    ar=simhashes.collect { |k, v| v }.uniq
    ar.each do |sh| 
      tree.add(sh)
    end
    # query for Alien 3, idsubtitlefile: 1953531228
    results=tree.query(NEEDLE_64,DISTANCE)
    #  puts results
    results=results.sort_by { |k,v| v }.to_h
     # arres=results.keys
     puts results
      arres=results.map { |key, value| key }
    # puts "sorted: #{arres}"
    arres.each do |s|
      subids = simhashes.select { |k,v| v == s}
      subids.each do |k,v|
        puts "found matching idsubtitlefile=#{k}, simhash=#{v}" unless k.to_i==ID_SUB.to_i
      end
    end


    # assert_equal [12136637984131628975, 12136637993795305391, 12136637984114851247, 12136637985339588015, 12136637993795304879], arres
  end

# def test_should_find_matching_128
#   puts "\n\ntest_should_find_matching_128"    
#   simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/export_simhash_128#{VARIATION}.yml"))
#   simhashes=YAML.load(simhashes_dump.read)
#   ar=simhashes.collect { |k, v| v }.uniq
#   ar.each do |sh| 
#     tree.add(sh)
#   end
#   # query for Alien 3, idsubtitlefile: 1953531228
#   results=tree.query(NEEDLE_128,DISTANCE)
#   # puts results
#   results=results.sort_by { |k,v| v }.to_h
#    # arres=results.keys
#      puts results
#        arres=results.map { |key, value| key }
#   #  puts "sorted: #{arres}"
#   arres.each do |s|
#     subids = simhashes.select { |k,v| v == s}
#     subids.each do |k,v|
#       puts "found matching idsubtitlefile=#{k}, simhash=#{v}" unless k.to_i==ID_SUB.to_i
#     end
#   end
#

    #  assert_equal [12136637984131628975, 12136637993795305391, 12136637984114851247, 12136637985339588015, 12136637993795304879], arres
#  end

  def test_should_find_matching_256
    puts "\n\ntest_should_find_matching_256"
    simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/export_simhash_256#{VARIATION}.yml"))
    simhashes=YAML.load(simhashes_dump.read)
    ar=simhashes.collect { |k, v| v }.uniq
    ar.each do |sh| 
      tree.add(sh)
    end
    # query for Alien 3, idsubtitlefile: 1953531228
    results=tree.query(NEEDLE_256,DISTANCE)
    #  puts results
    results=results.sort_by { |k,v| v }.to_h
     # arres=results.keys
       puts results
         arres=results.map { |key, value| key }
    #   puts "sorted: #{arres}"
    arres.each do |s|
      subids = simhashes.select { |k,v| v == s}
      subids.each do |k,v|
        puts "found matching idsubtitlefile=#{k}, simhash=#{v}" unless k.to_i==ID_SUB.to_i
      end
    end


    #  assert_equal [12136637984131628975, 12136637993795305391, 12136637984114851247, 12136637985339588015, 12136637993795304879], arres
  end


   def test_should_find_matching_ruby_128
     puts "\n\ntest_should_find_matching_ruby_128"
     simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/export_simhash_ruby_128.yml'))
     simhashes=YAML.load(simhashes_dump.read)
     ar=simhashes.collect { |k, v| v }.uniq
     ar.each do |sh| 
       tree.add(sh)
     end
     # query for Alien 3, idsubtitlefile: 1953531228
     results=tree.query(NEEDLE_RUBY_128,DISTANCE)

     results=results.sort_by { |k,v| v }.to_h
  puts results    
    # arres=results.keys
     arres=results.map { |key, value| key }
       puts results

     arres.each do |s|
       subids = simhashes.select { |k,v| v == s}
       subids.each do |k,v|
         puts "found matching idsubtitlefile=#{k}, simhash=#{v}" unless k.to_i==ID_SUB.to_i
       end
     end
   end


  def test_should_find_matching_ruby_256
    puts "\n\ntest_should_find_matching_ruby_256\n PID:#{Process.pid}"
    simhashes_dump=File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/export_simhash_ruby_256.yml'))
    simhashes=YAML.load(simhashes_dump.read)
    ar=simhashes.collect { |k, v| v }.uniq
    ar.each do |sh| 
      tree.add(sh)
    end
 #    sleep(160)
    # query for Alien 3, idsubtitlefile: 1953531228
    results=tree.query(NEEDLE_RUBY_256,DISTANCE)
   
    results=results.sort_by { |k,v| v }.to_h
 puts results    
   # arres=results.keys
    arres=results.map { |key, value| key }
      puts results

    arres.each do |s|
      subids = simhashes.select { |k,v| v == s}
      subids.each do |k,v|
        puts "found matching idsubtitlefile=#{k}, simhash=#{v}" unless k.to_i==ID_SUB.to_i
      end
    end
#     sleep(60)
  end
  
#def test_just_waist_some_time
#  puts "will now waiste some time"
#  ar=[]
#  r = Random.new
#  100000000.times do  
#    n=r.rand(1000000000000000000000000000000000000000000000000000000000000...999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)
#    ar<<n
#  end
#  puts "size=#{ar.size}"
# 
#  
#end
  
end



#        idsubtitlefile	moviename similarity
#        1952177992	Alien3 98.4375%
#        1951901932	Alien3 98.046875%
#        197896	Alien3 97.65625%
#        175312	Alien3 97.65625%
#        1951687825	Alien3 92.578125%
