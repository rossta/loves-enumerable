Project = Struct.new(:name)

colors = ['aliceblue', 'ghostwhite'].cycle
projects = [Project.new("TODO"),
            Project.new("Work"),
            Project.new("Home")]

ProjectRow = Struct.new(:name, :color, :number)

rows = projects.zip(colors.cycle).map.with_index(1) do |(project, color), n|
  ProjectRow.new(project.name, color, n)
end

p rows

# [#<struct ProjectRow name="TODO", color="aliceblue", number=1>,
#  #<struct ProjectRow name="Work", color="ghostwhite", number=2>,
#  #<struct ProjectRow name="Home", color="aliceblue", number=3>]
