require 'benchmark/ips'

require 'benchmark'

[10000, 100000, 1000000, 10000000].each do |size|
  Benchmark.ips do |x|
    x.report("#{size} without lazy") do
      hashes = (0..size).select(&:zero?).map(&:hash).map(&:to_s)
    end

    x.report("#{size} lazy") do
      hashes = (0..size).lazy.select(&:zero?).map(&:hash).map(&:to_s).to_a
    end
  end
end
 
# values = (0..100).to_a
 
# Benchmark.ips do |x|
#    x.report("regular") do
#       values.map { |x| x * 10 }.select { |x| x > 30 } 
#    end
#    x.report("lazy") do
#       values.lazy.map { |x| x * 10 }.select { |x| x > 30 } 
#    end
# end
