# from JEG2
Person = Struct.new(:name, :team)

people = [Person.new("James", "sales"),
          Person.new("Molly", "tech"),
          Person.new("Ally",  "tech")]

tech, sales = people.partition { |p| p.team == "tech" }
puts "Tech:", tech.map { |p| "  %s" % p.name }
puts "Sales:", sales.map { |p| "  %s" % p.name }

Tech:
  Molly
  Ally
Sales:
  James
