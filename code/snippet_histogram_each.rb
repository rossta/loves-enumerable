file = File.open(File.expand_path("../../data/Old-Friend.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z]{4,16}\b}i)

histogram = {}
words.each do |w|
  histogram[w] ||= 0
  histogram[w] += 1
end
histogram

puts histogram.sort_by { |k, v| -v }.to_h

{"know"=>12, "believe"=>10, "easier"=>5, "when"=>5, "want"=>4, "could"=>4, "much"=>4, "getting"=>3, "just"=>3, "from"=>2, "disappeared"=>2, "city"=>2, "used"=>2, "make"=>2, "through"=>2, "friend"=>2, "went"=>2, "older"=>2, "growing"=>2, "less"=>2, "action"=>2, "water"=>2, "come"=>2, "enough"=>2, "stood"=>2, "rooftop"=>2, "night"=>2, "clear"=>2, "that"=>2, "lights"=>2, "gate"=>2, "fates"=>1, "against"=>1, "push"=>1, "alone"=>1, "were"=>1, "always"=>1, "though"=>1, "even"=>1, "everything"=>1, "home"=>1, "back"=>1, "north"=>1, "east"=>1, "following"=>1, "footsteps"=>1, "some"=>1, "beautiful"=>1, "beast"=>1, "park"=>1, "cool"=>1, "eucalyptus"=>1, "leaves"=>1, "look"=>1, "over"=>1, "must"=>1, "fallow"=>1, "couldn"=>1, "wait"=>1, "away"=>1, "like"=>1, "supposed"=>1}
