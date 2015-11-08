require 'csv'
require 'pry'

CSV.open('../data/college.csv', 'rb', headers: true) do |csv|
  names = csv.each.with_index.lazy.map do |cs, i|
    puts i; cs['INSTNM']
  end.grep(/^q/i).take(5).force

  puts names
end
