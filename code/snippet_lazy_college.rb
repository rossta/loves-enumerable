# Data from http://catalog.data.gov/dataset/college-scorecard

if !File.exist?(File.expand_path('../../data/college-scorecard.csv', __FILE__))
  puts "This snippet requires a college scorecard csv:"
  puts "* Download datasets from http://catalog.data.gov/dataset/college-scorecard"
  puts "* Move one of the csv files into the ./data directory and rename it 'college-scorecard.csv'"
  exit
end

require 'csv'

CSVAdmissionRate = Struct.new(:range) do
  def ===(row)
    rate = row['ADM_RATE'].to_f
    rate > 0 && range === rate
  end
end

CSV.open(File.expand_path('../../data/college-scorecard.csv', __FILE__),
         'rb', headers: true) do |csv|

  results = csv.each.lazy.
    grep(CSVAdmissionRate.new(0.0..0.10)).
    take(10).
    each_with_object({}) do |row, data|
      puts row['INSTNM']    # streaming results
      data[row['INSTNM']] = {
        city:   row['CITY'],
        state:  row['STABBR'],
        url:    row['INSTURL'] }
    end

  puts
  puts results
end

# Yale University
# University of Chicago
# Harvard University
# Massachusetts Institute of Technology
# Dartmouth College
# Princeton University
# Columbia University in the City of New York
# Cooper Union for the Advancement of Science and Art
# The Juilliard School
# Curtis Institute of Music
#
# {"Yale University"=>{:city=>"New Haven", :state=>"CT", :url=>"www.yale.edu"}, "University of Chicago"=>{:city=>"Chicago", :state=>"IL", :url=>"WWW.UCHICAGO.EDU"}, "Harvard University"=>{:city=>"Cambridge", :state=>"MA", :url=>"www.harvard.edu"}, "Massachusetts Institute of Technology"=>{:city=>"Cambridge", :state=>"MA", :url=>"web.mit.edu/student/"}, "Dartmouth College"=>{:city=>"Hanover", :state=>"NH", :url=>"www.dartmouth.edu"}, "Princeton University"=>{:city=>"Princeton", :state=>"NJ", :url=>"www.princeton.edu"}, "Columbia University in the City of New York"=>{:city=>"New York", :state=>"NY", :url=>"www.columbia.edu"}, "Cooper Union for the Advancement of Science and Art"=>{:city=>"New York", :state=>"NY", :url=>"www.cooper.edu"}, "The Juilliard School"=>{:city=>"New York", :state=>"NY", :url=>"www.juilliard.edu"}, "Curtis Institute of Music"=>{:city=>"Philadelphia", :state=>"PA", :url=>"www.curtis.edu"}}
