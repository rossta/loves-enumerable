require "minitest/autorun"
require_relative "./sorted_list"

describe "Custom Enumerator" do
  before do
    @list = SortedList.new

    @list << 3 << 13 << 42 << 4 << 7
  end

  it "supports next" do
    enum = @list.each

    enum.next.must_equal(3)
    enum.next.must_equal(4)
    enum.next.must_equal(7)
    enum.next.must_equal(13)
    enum.next.must_equal(42)

    assert_raises(StopIteration) { enum.next }
  end

  it "supports generator function" do
    enum = CustomEnumerator.new do |y|
      a = 0
      loop do
        y.yield a
        a += 1
      end
    end

    enum.take(5).must_equal [0, 1, 2, 3, 4]
  end

  it "works with raw generator function" do
    enum = CustomGenerator.new do |y|
      a = 0
      loop do
        y.yield a
        a += 1
      end
    end

    enum.take(5).must_equal [0, 1, 2, 3, 4]
  end

  it "supports rewind" do
    enum = @list.each

    4.times { enum.next }
    enum.rewind

    2.times { enum.next }
    enum.next.must_equal(7)
  end

  it "supports with_index" do
    enum = @list.map

    expected = ["0. 3", "1. 4", "2. 7", "3. 13", "4. 42"]
    enum.with_index { |e,i| "#{i}. #{e}" }.must_equal(expected)
  end

end
