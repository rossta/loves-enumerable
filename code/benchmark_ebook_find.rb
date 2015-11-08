require "benchmark"

Benchmark.benchmark do |x|
  x.report("each_line") do
    File.open("/Users/ross/tmp/ulysses-1000.txt", "rb") do |f|
      foo = []
      f.each_line do |l|
        foo << l if l =~ /boy/i
        break if foo.length == 5
      end
      foo.length
    end
  end

  x.report("each_line enumerator") do
    File.open("/Users/ross/tmp/ulysses-1000.txt", "rb") do |f|
      f.each_line.select { |l| l =~ /boy/i }.first(5)
    end
  end

  x.report("each_line lazy enumerator") do
    File.open("/Users/ross/tmp/ulysses-1000.txt", "rb") do |f|
      f.each_line.lazy.select { |l| l =~ /boy/i }.first(5)
    end
  end
end
