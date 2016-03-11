require 'minitest/autorun'
require 'minitest/pride'
require_relative './method_decorator'

require 'stringio'

module Kernel
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
end

class TestMethodDecorator < Minitest::Test

  def test_decorator_initialization
    output = capture_stdout do
      my_decorator = Class.new do
        def initialize(method)
          puts "Inside MyDecorator##{__METHOD__}"
          @method = method
        end

        def call(*args)
          puts "Inside MyDecorator##{__METHOD__}"
        end
      end
      Object.const_set("MyDecorator", my_decorator)
      MyDecorator.send(:include, MethodDecorator)

      my_class = Class.new do
        MyDecorator()
        def a_method
          puts "Inside MyClass##{__METHOD__}"
        end
      end

      puts "Finished decorating a_method"

      my_class.new.a_method
    end

    expected = []
    expected << "Inside MyDecorator#initialize"
    expected << "Inside MyClass#a_method"
    expected << "Finished decorating a method"
    expected << "Inside MyDecorator#call"

    assert_equal expected.join("\n"), output
  end
end
