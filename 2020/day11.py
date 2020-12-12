
from numpy import matrix, zeros, fromfunction, vectorize, \
        logical_or, logical_and
from itertools import tee

def seat_matrix_from_file(f):
    return matrix([[seat == 'L' for seat in line] for line in f], dtype=int)

def expand_matrix(m):
    ax0, ax1 = m.shape
    padded = zeros((ax0+2, ax1+2), dtype=int)
    padded[1:-1, 1:-1] = m
    return padded

dirs = [(x,y) for x in (-1,0,1) for y in (-1,0,1) if x!=0 or y!=0]

def adjacents(m):
    ax0, ax1 = m.shape
    new = expand_matrix(m)
    return (new[dx+1:dx+1+ax0, dy+1:dy+1+ax1] for dx, dy in dirs)

def seats_in_next_round(seats, occupied):
    adj_sum = sum(adjacents(occupied))
    return logical_or(logical_and(seats, adj_sum == 0),
            logical_and(occupied, adj_sum < 4)).astype(int)

def seat_history(seats, reloc_method):
    occupied = zeros(seats.shape, dtype=int)
    gen = 0
    while True:
        print("gen", gen, "occupied", occupied.sum())
        yield occupied
        occupied = reloc_method(seats, occupied)
        gen += 1

def nonchanging_order(history):
    h1, h2 = tee(history, 2)
    next(h2)
    return next(s1 for s1, s2 in zip(h1, h2) if (s1==s2).all())

def first_visible_seat(seats, pos, dir):
    newpos = (pos[0]+dir[0], pos[1]+dir[1])
    if newpos[0] < 0 or newpos[1] < 0: return None
    try:
        if seats[newpos]: return newpos
    except IndexError: return None
    return first_visible_seat(seats, newpos, dir)

def count_occupied_visible_seats(seats, occupied, pos):
    return sum(occupied[visible_seat] for visible_seat in
            (first_visible_seat(seats, pos, dir) for dir in dirs)
            if visible_seat is not None)

def seats_in_next_round2(seats, occupied):
    def seat_now_occupied(x, y):
        pos = (x, y)
        ovs = count_occupied_visible_seats(seats, occupied, pos)
        return 1*((seats[pos] and ovs == 0) or (occupied[pos] and ovs < 5))
    return fromfunction(vectorize(seat_now_occupied), seats.shape, dtype=int)

def seat_count_when_stabilises(seats, reloc_method):
    return nonchanging_order(seat_history(seats, reloc_method)).sum()

if __name__ == '__main__':
    import sys
    seats = seat_matrix_from_file(open(sys.argv[1]))
    print(seat_count_when_stabilises(seats, seats_in_next_round))
    print(seat_count_when_stabilises(seats, seats_in_next_round2))

