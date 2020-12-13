
from functools import reduce

def params_from_file(f):
    time = int(next(f))
    moduli = [(int(cycle), pos) for pos, cycle in enumerate(next(f).split(','))
            if cycle != 'x']
    return time, moduli

def shortest_waiting_time(time, moduli):
    return min((cycle - time % cycle, cycle) for cycle, offset in moduli)

def find_new_offset(factor1, offset1, factor2, offset2):
    if factor1 < factor2:
        factor1, offset1, factor2, offset2 = factor2, offset2, factor1, offset1
    while factor2 > 1:
        factor1, offset1, factor2, offset2 = (
                factor2, offset2, factor1 % factor2,
                (offset1 - offset2 * (factor1 // factor2)))
    return offset2

def combine_moduli(modulus1, modulus2):
    factor1, offset1 = modulus1
    factor2, offset2 = modulus2
    new_factor = factor1 * factor2
    return (new_factor, find_new_offset(
        factor1, offset2*factor1, factor2, offset1*factor2) % new_factor)

if __name__ == '__main__':
    import sys
    time, moduli = params_from_file(open(sys.argv[1]))
    print(moduli)
    waiting, line_id = shortest_waiting_time(time, moduli)
    print(waiting * line_id)
    cycle, time = reduce(combine_moduli, moduli)
    print(cycle - time)

