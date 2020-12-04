from itertools import product

def file_to_numlist(filename):
    return [int(line) for line in open(filename)]

def cartesian_power(list, power):
    return product(*([list]*power))

def numbers_of_sum(total, nums, power):
    return (comb for comb in cartesian_power(nums, power) if sum(comb) == total)

if __name__ == '__main__':
    import sys
    numlist = file_to_numlist(sys.argv[1])
    for n1, n2 in numbers_of_sum(2020, numlist, 2): print(n1*n2)
    for n1, n2, n3 in numbers_of_sum(2020, numlist, 3): print(n1*n2*n3)

