require 'minitest/autorun'
require 'minitest/pride'
require_relative './snake_case'

class TestSnakeCase < Minitest::Test
  def test_iterative
    assert_equal 6, SnakeCase::Iterative.path_count(2, 2)
    assert_equal 10, SnakeCase::Iterative.path_count(3, 2)
    assert_equal 330, SnakeCase::Iterative.path_count(4, 7)
    assert_equal 184_756, SnakeCase::Iterative.path_count(10, 10)
  end

  def test_enumrative
    assert_equal 6, SnakeCase::Enumerative.path_count(2, 2)
    assert_equal 10, SnakeCase::Enumerative.path_count(3, 2)
    assert_equal 330, SnakeCase::Enumerative.path_count(4, 7)
    require 'pry'; binding.pry
    assert_equal 184_756, SnakeCase::Enumerative.path_count(10, 10)
  end

  def test_recursive
    assert_equal 6, SnakeCase::Recursive.path_count(2, 2)
    assert_equal 10, SnakeCase::Recursive.path_count(3, 2)
    assert_equal 330, SnakeCase::Recursive.path_count(4, 7)
    assert_equal 184_756, SnakeCase::Recursive.path_count(10, 10)
  end

  def test_factorial
    assert_equal 6, SnakeCase::Factorial.path_count(2, 2)
    assert_equal 10, SnakeCase::Factorial.path_count(3, 2)
    assert_equal 330, SnakeCase::Factorial.path_count(4, 7)
    assert_equal 184_756, SnakeCase::Factorial.path_count(10, 10)
  end

  def test_brute_force
    assert_equal 6, SnakeCase::Bruteforce.path_count(2, 2)
    assert_equal 10, SnakeCase::Bruteforce.path_count(3, 2)
    assert_equal 330, SnakeCase::Bruteforce.path_count(4, 7)
    assert_equal 184_756, SnakeCase::Bruteforce.path_count(10, 10)
  end
end
