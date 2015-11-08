User = Struct.new(:name)

users = [User.new('Andie'),
         User.new('Duckie'),
         User.new('Steff'),
         User.new('John H')]

p users.find { |u| u.name == "Duckie" }

p users.find { |u| u.name == "Ross" } || User.new(name: 'Guest')

p users.find(-> { User.new(name: 'Guest') }) { |u| u.name == "Ross" }

users.find(-> { raise "404!" }) do |u|
  u.name.start_with?('Z')
end rescue puts $!.class

# '#<struct User name="Duckie">'
# '#<struct User name={:name=>"Guest"}>'
# '#<struct User name={:name=>"Guest"}>'
# RuntimeError
