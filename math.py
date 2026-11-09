import numpy as np

def cal_sum_of_arguments(*args):
    _sum = 0
    for args in args:
        _sum += arg
    return _sum

#print(cal_sum_of_arguments(1, 2, 3))

# vector
vector = np.array([1, 2, 3])
print(vector.ndim)
print(vector.shape)
print(f'Vector => {vector}')

# matrix
matrix = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])
print(matrix.ndim)
print(matrix.shape)
print(f'Matrix => {matrix}')

# Tensor
tensor = np.array([
    [
        [1, 2, 3],
        [4, 5, 6]
    ],
    [
        [7, 8, 9],
        [10, 11, 12]
    ]
])
print(tensor.ndim)
print(tensor.shape)
print(f'Tensor {tensor}')
