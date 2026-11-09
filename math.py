def cal_sum_of_arguments(*args):
    _sum = 0
    for arg in args:
        _sum += arg
    return _sum

print(cal_sum_of_arguments(1, 2, 3))
