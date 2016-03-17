def fibonacci(limit):
    a, b, c = 0, 1, 0
    while c < limit:
        yield a
        a, b, c = b, a+b, c+1

for number in fibonacci(100):  # The generator constructs an iterator
    print(number)
