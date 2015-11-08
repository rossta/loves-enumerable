require 'date'

eighties = Date.new(1980, 1, 1)...Date.new(1990, 1, 1)
dates = [Date.new(1988, 7, 15),
         Date.new(1990, 1, 1),
         Date.new(1977, 8, 16)]

p dates.select { |date| eighties.member?(date) }.map { |d| d.to_s }

p eighties === Date.new(1988, 7, 15)
p eighties === Date.new(1977, 8, 16)

p dates.grep(eighties) { |d| d.to_s }
p dates.grep(eighties, &:to_s)

["1988-07-15"]
true
false
["1988-07-15"]
["1988-07-15"]
