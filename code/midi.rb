require 'unimidi'

notes = [36, 40, 43, 48, 52, 55, 60, 64, 67] # C E G arpeggios
duration = 0.1

out = UniMIDI::Output.all.last

# notes = [36, 40, 43, 48, 52, 55, 60, 64, 67]
notes = [43, 36, 40, 48, 55, 52, 60, 67, 48, 64, 55, 52]

[0, 5, 3, 7, 0].each do |step|
  notes.cycle(4).with_index.lazy.map { |n, i| out.puts(0x90, n + step, 100) }.each { |n, i| sleep(duration) }.take(1).each { |n| out.puts(0x90, n, 500) }
end
