file = File.open(File.expand_path("../../data/Thriller.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z']{2,16}\b}i)

puts words.inspect

histogram = {}
words.each do |w|
  histogram[w] ||= 0
  histogram[w] += 1
end

puts histogram.sort_by { |k, v| -v }.take(6).to_h

# words = ["it's", "close", "to", "midnight", "and", "something", "evil's", "lurking", "in", "the", "dark"]
#
# {"the"=>29, "you"=>23, "thriller"=>20, "and"=>14, "to"=>12, "night"=>10, "is"=>9, "your"=>8, "of"=>7, "this"=>7, "in"=>6, "it's"=>5, "for"=>5, "close"=>4, "cause"=>4, "you're"=>4, "that"=>4, "killer"=>4, "no"=>4, "try"=>3, "inside"=>3, "life"=>3, "time"=>3, "tonight"=>3, "ever"=>3, "see"=>3, "from"=>3, "eyes"=>3, "on"=>3, "can"=>3, "there's"=>3, "start"=>2, "every"=>2, "make"=>2, "closing"=>2, "they're"=>2, "creatures"=>2, "thrill"=>2, "more"=>2, "forty"=>2, "than"=>2, "any"=>2, "but"=>2, "ghost"=>2, "would"=>2, "dare"=>2, "girl"=>2, "so"=>2, "save"=>2, "let"=>2, "out"=>2, "all"=>2, "me"=>2, "know"=>2, "fighting"=>2, "hold"=>2, "tight"=>2, "share"=>2, "diller"=>2, "midnight"=>2, "hear"=>2, "hand"=>2, "i'll"=>2, "falls"=>1, "slam"=>1, "nowhere"=>1, "left"=>1, "run"=>1, "feel"=>1, "cold"=>1, "door"=>1, "wonder"=>1, "if"=>1, "you'll"=>1, "strike"=>1, "sun"=>1, "hope"=>1, "just"=>1, "imagination"=>1, "about"=>1, "while"=>1, "creature"=>1, "creepin"=>1, "up"=>1, "behind"=>1, "beast"=>1, "gonna"=>1, "one's"=>1, "there"=>1, "ain't"=>1, "second"=>1, "chance"=>1, "against"=>1, "thing"=>1, "with"=>1, "paralyzed"=>1, "between"=>1, "call"=>1, "dead"=>1, "walk"=>1, "their"=>1, "masquerade"=>1, "escapin"=>1, "jaws"=>1, "alien"=>1, "right"=>1, "open"=>1, "wide"=>1, "end"=>1, "get"=>1, "demons"=>1, "looks"=>1, "horror"=>1, "as"=>1, "side"=>1, "they"=>1, "will"=>1, "possess"=>1, "unless"=>1, "change"=>1, "number"=>1, "dial"=>1, "now"=>1, "cuddle"=>1, "together"=>1, "through"=>1, "freeze"=>1, "terrors"=>1, "screen"=>1, "it"=>1, "before"=>1, "sound"=>1, "takes"=>1, "terror"=>1, "scream"=>1, "heart"=>1, "stops"=>1, "almost"=>1, "sight"=>1, "moonlight"=>1, "under"=>1, "dark"=>1, "lurking"=>1, "evil's"=>1, "something"=>1, "chiller"=>1, "here"=>1, "darkness"=>1, "realize"=>1, "across"=>1, "land"=>1, "hour"=>1, "at"=>1, "crawl"=>1, "search"=>1, "blood"=>1, "terrorize"=>1, "y'awl's"=>1, "neighborhood"=>1, "whosoever"=>1, "shall"=>1, "be"=>1, "found"=>1, "without"=>1, "soul"=>1, "getting"=>1, "down"=>1, "must"=>1, "stand"=>1, "face"=>1, "hounds"=>1, "hell"=>1, "rot"=>1, "corpse's"=>1, "shell"=>1, "foulest"=>1, "stench"=>1, "air"=>1, "funk"=>1, "thousand"=>1, "years"=>1, "grizzly"=>1, "ghouls"=>1, "tomb"=>1, "are"=>1, "seal"=>1, "doom"=>1, "though"=>1, "fight"=>1, "stay"=>1, "alive"=>1, "body"=>1, "starts"=>1, "shiver"=>1, "mere"=>1, "mortal"=>1, "resist"=>1, "evil"=>1}
