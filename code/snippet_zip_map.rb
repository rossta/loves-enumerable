row = [1, 2, 1]

p row = ([0] + row).zip(row + [0])
p row = row.map { |a, b| a + b }

# [[0, 1], [1, 2], [2, 1], [1, 0]]
# [1, 3, 3, 1]
