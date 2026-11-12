X = [1, 2, 3, 4]

X.reverse()  # in-place
print(X)

# functional programing
R = reversed(X)  # Returns an iterator without modifying the original list.
print(list(R))

a = list(filter(lambda x: x % 2 == 0, range(0, 100)))
