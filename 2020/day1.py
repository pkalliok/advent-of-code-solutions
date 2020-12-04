from itertools import product
from math import log, exp

def file_to_numlist(filename):
    return [int(line) for line in open(filename)]

def cartesian_power(list, power):
    return product(*([list]*power))

def numbers_of_sum(total, nums, power):
    return (comb for comb in cartesian_power(nums, power) if sum(comb) == total)

if __name__ == '__main__':
    import sys
    numlist = file_to_numlist(sys.argv[1])
    for power in (2,3):
        for solution in numbers_of_sum(2020, numlist, power):
            print(exp(sum(log(n) for n in solution)))

