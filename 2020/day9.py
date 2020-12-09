
def file_to_list(f): return [int(line) for line in f]

def blocks(ls):
    return ((ls[i], ls[i-25:i]) for i in range(25,len(ls)))

def block_invalid(block):
    num, prevs = block
    return not any(True
            for n1 in prevs for n2 in prevs
            if n1 + n2 == num if n1 != n2)

def first_invalid_number(ls):
    return next(filter(block_invalid, blocks(ls)))[0]

def cont_range_totalling(total, ls):
    start, end, running = 0, 1, ls[0]
    while end < len(ls):
        if end - start < 2 or running < total:
            running += ls[end]
            end += 1
        elif running > total:
            running -= ls[start]
            start += 1
        else: return ls[start:end]

if __name__ == '__main__':
    import sys
    ls = file_to_list(open(sys.argv[1]))
    inv = first_invalid_number(ls)
    print(inv)
    rng = cont_range_totalling(inv, ls)
    print(min(rng) + max(rng))

