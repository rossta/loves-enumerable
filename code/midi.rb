require 'unimidi'

out = UniMIDI::Output.all.last

notes = [36, 43, 40, 48, 52, 55, 64, 67, 60, 55, 52, 48]
steps = [0, 5, 3, 7]

steps.each do |step|
  notes.cycle(2).
    lazy.
    map { |n, i| out.puts(0x90, n + step, 100) }.
    each { |n, i| sleep(0.1) }
end
