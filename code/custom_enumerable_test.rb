require "minitest/autorun"
require_relative "./custom_list"

describe "CustomEnumerable" do
  before do
    @list = CustomList.new(3, 13, 42, 4, 7)
  end

  it "supports map" do
    @list.map { |x| x + 1 }.must_equal([4, 14, 43, 5, 8])
  end

  it "supports find" do
    @list.find { |x| x > 40 }.must_equal(42)
    @list.find(-> { 0 }) { |x| x > 50 }.must_equal(0)
  end

  it "supports select" do
    @list.select { |x| x.even? }.must_equal([42, 4])
  end

  # it "supports sort_by" do
  #   # ascii sort order
  #   @list.sort_by { |x| x.to_s }.must_equal([13, 3, 4, 42, 7])
  # end
  #
  # it "supports reduce" do
  #   @list.reduce(:+).must_equal(69)
  #   @list.reduce { |s,e| s + e }.must_equal(69)
  #   @list.reduce(-10) { |s,e| s + e }.must_equal(59)
  # end
end
