Project = Struct.new(:name)

colors = ['aliceblue', 'ghostwhite'].cycle
projects = [Project.new("TODO"),
            Project.new("Work"),
            Project.new("Home")]

require 'erb'

erb = (<<-ERB)
<table>
<% projects.each_with_index do |project, index| %>
 <tr style="background: <%= colors.next %>">
   <td><%= index + 1 %></td>
   <td><%= project.name %></td>
 </tr>
<% end %>
</table>
ERB

puts ERB.new(erb).result(binding).gsub(/^$\n/, "")

# <table>
#  <tr style="background: aliceblue">
#    <td>1</td>
#    <td>TODO</td>
#  </tr>
#  <tr style="background: ghostwhite">
#    <td>2</td>
#    <td>Work</td>
#  </tr>
#  <tr style="background: aliceblue">
#    <td>3</td>
#    <td>Home</td>
#  </tr>
# </table>
