#https://github.com/fredwu/ruby_decorators
module MethodDecorator
  def self.extended(klass)
    define_method(klass.name) do
      raise "foo"
    end
  end
end
