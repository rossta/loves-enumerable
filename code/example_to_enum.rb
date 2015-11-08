class CustomCollection
  include Enumerable

  def each
    return to_enum(:each) unless block_given?
    # ...
  end
end
