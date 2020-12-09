
def file_to_list(f): return [int(line) for line in f]

def blocks(ls):
    return ((ls[i], ls[i-25:i]) for i in range(25,len(ls)))

def block_invalid(block):
    num, prevs = block
    return not any(True
            for n1 in prevs for n2 in prevs
            if n1 + n2 == num if n1 != n2)

if __name__ == '__main__':
    import sys
    print(next(filter(block_invalid, blocks(file_to_list(open(sys.argv[1]))))))
