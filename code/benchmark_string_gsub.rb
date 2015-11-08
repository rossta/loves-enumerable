require "benchmark/ips"

STRING = "\nLorem ipsum\ntempor invidunt\n\naliquyam erat\nvero eos\nno sea. Lorem\n\nipsum\n"

# Desired end result:
# <span>Lorem ipsum</span>
# <span>tempor invidunt</span>
# <span>aliquyam erat</span>
# <span>vero eos</span>
# <span>no sea. Lorem</span>
# <span>ipsum</span>

Benchmark.ips do |x|
  x.report("lines + map") do
    STRING.squeeze("\n").strip!.lines.map! { |line| "<span>#{line}</span>" }.join
  end
  x.report("each_line + inject") do
    STRING.squeeze("\n").strip!.each_line.inject("") { |s, line| s << "<span>#{line}</span>" }
  end
  x.report("map with if") do
    STRING.lines.map! { |line| "<span>#{line}</span>" unless line.strip!.empty? }.join
  end
  x.report("reject + map") do
    STRING.lines.reject { |line| line.strip!.empty? }.map! { |line| "<span>#{line}</span>" }.join
  end
  x.report("gsub") do
    STRING.gsub(/^(.+)$/) { |line| "<span>#{line}</span>" }
  end
  x.compare! # Output the comparison
end
