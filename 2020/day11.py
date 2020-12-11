
from numpy import matrix, zeros, multiply, vectorize, indices
from itertools import tee

def seat_matrix_from_file(f):
    return matrix([[seat == 'L' for seat in line] for line in f], dtype=int)

def expand_matrix(m):
    ax0, ax1 = m.shape
    padded = zeros((ax0+2, ax1+2), dtype=int)
    padded[1:-1, 1:-1] = m
    return padded

dirs = [(x,y) for x in (0,1,2) for y in (0,1,2) if x!=1 or y!=1]

def adjacents(m):
    ax0, ax1 = m.shape
    new = expand_matrix(m)
    return (new[dx:dx+ax0, dy:dy+ax1] for dx, dy in dirs)

def seats_in_next_round(seats, occupied):
    adj_sum = sum(adjacents(occupied))
    return ((multiply(seats, adj_sum == 0) +
        multiply(occupied, adj_sum < 4)) > 0).astype(int)

def seat_history(seats, reloc_method):
    occupied = zeros(seats.shape, dtype=int)
    while True:
        yield occupied
        occupied = reloc_method(seats, occupied)

def nonchanging_order(history):
    h1, h2 = tee(history, 2)
    next(h2)
    return next(s1 for s1, s2 in zip(h1, h2) if (s1==s2).all())

if __name__ == '__main__':
    import sys
    print(nonchanging_order(seat_history(
        seat_matrix_from_file(open(sys.argv[1])),
        seats_in_next_round)).sum())

