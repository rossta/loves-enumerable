# from Ruby Docs
module Enumerable
  # weighted random sampling.
  #
  # Pavlos S. Efraimidis, Paul G. Spirakis
  # Weighted random sampling with a reservoir
  # Information Processing Letters
  # Volume 97, Issue 5 (16 March 2006)
  def wsample(n)
    self.max_by(n) {|v| rand ** (1.0/yield(v)) }
  end
end
e = (-20..20).to_a*10000
a = e.wsample(20000) {|x|
  Math.exp(-(x/5.0)**2) # normal distribution
}
# a is 20000 samples from e.
p a.length #=> 20000
h = a.group_by {|x| x }
-10.upto(10) {|x| puts "*" * (h[x].length/30.0).to_i if h[x] }
