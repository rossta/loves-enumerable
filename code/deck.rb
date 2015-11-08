class Deck
  include Enumerable

  SUITS = %w[ C D H S ]
  RANKS = %w[ 2 3 4 5 6 7 8 9 10 J Q K A ]

  def initialize(n = 1)
    @cards ||= SUITS.cycle(1).flat_map do |suit|
      RANKS.map do |rank|
        [suit, rank]
      end
    end
  end

  def each(&block)
    @cards.each(&block)
  end

  def cut
    cut_at = rand(count)
    each_with_index.partition { |card, i| puts i; i < cut_at }
  end
end

if __FILE__ == $0
  deck = Deck.new

  p deck.cut
end
