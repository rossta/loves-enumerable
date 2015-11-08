# from JEG2

headings = ["1.1 The Joy of Each",
            "2.1 Exploring Enumerable",
            "2.2 Implementing Enumerable",
            "3.1 Discovering Enumerator",
            "3.2 Dissecting Enumerator",
            "4.1 Next"]

headings.chunk { |header| header[/\A\d+/] }
        .each do |chapter, headings|
          puts "Chapter #{chapter}"
          puts headings.map { |heading| "  #{heading}" }
        end

Chapter 1
  1.1 The Joy of Each
Chapter 2
  2.1 Embracing Enumerable
  2.2 Implementing Enumerable
Chapter 3
  3.1 Exploring Enumerator
  3.2 Dissecting Enumerator
Chapter 4
  4.1 Next
