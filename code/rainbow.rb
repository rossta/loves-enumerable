class Rainbow
  include Enumerable

  def each
    yield "red"
    yield "orange"
    yield "yellow"
    yield "green"
    yield "blue"
    yield "indigo"
    yield "violet"
  end
end

if __FILE__ == $0
  rainbow = Rainbow.new
  puts rainbow.map { |color| "Next color: #{color}" }
  puts
  puts "Starts with y?",
    rainbow.find {|color| color.start_with?('y') }

  # Next color: red
  # Next color: orange
  # Next color: yellow
  # Next color: green
  # Next color: blue
  # Next color: indigo
  # Next color: violet
  #
  # Starts with y?
  # yellow
end
