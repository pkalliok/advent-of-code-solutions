
def file_to_numlist(filename):
    return [int(line) for line in open(filename)]

def numbers_of_sum(total, nums):
    return ((n1, n2) for n1 in nums for n2 in nums if n1+n2 == total)

if __name__ == '__main__':
    import sys
    for n1, n2 in numbers_of_sum(2020, file_to_numlist(sys.argv[1])):
        print(n1*n2)

