import sys
f = open(sys.argv[1])
time = int(next(f))
cycles = [int(cycle) for cycle in next(f).split(',') if cycle != 'x']
possibilities = sorted((cycle - time % cycle, cycle) for cycle in cycles)
waiting, lineid = possibilities[0]
print(waiting * lineid)
