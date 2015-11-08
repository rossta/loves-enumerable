def pascal_row(row = [1])
 ([0] + row).zip(row + [0]).map { |a, b| a + b }
end

row = [1]

p row
p row = pascal_row(row)
p row = pascal_row(row)
p row = pascal_row(row)
p row = pascal_row(row)

[1]
[1, 1]
[1, 2, 1]
[1, 3, 3, 1]
[1, 4, 6, 4, 1]
