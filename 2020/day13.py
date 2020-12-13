
def params_from_file(f):
    time = int(next(f))
    moduli = [(int(cycle), pos) for pos, cycle in enumerate(next(f).split(','))
            if cycle != 'x']
    return time, moduli

def shortest_waiting_time(time, moduli):
    return min((cycle - time % cycle, cycle) for cycle, offset in moduli)

if __name__ == '__main__':
    import sys
    time, moduli = params_from_file(open(sys.argv[1]))
    waiting, line_id = shortest_waiting_time(time, moduli)
    print(waiting * line_id)

