def foo
  fiber = Proc.new do
    puts "before yield"

    yield "Foo"

    puts "after yield"
  end

  puts "before call"

  fiber.call

  puts "after call"
end

foo { |f| puts f }
