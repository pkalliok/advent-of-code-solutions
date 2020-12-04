
def route(map, angle):
    return (line[(i * angle) % len(line)] for i, line in enumerate(map))

if __name__ == '__main__':
    import sys
    mymap = [line.rstrip() for line in open(sys.argv[1])]
    print(list(route(mymap,3)))
    print(sum(1 for obj in route(mymap, 3) if obj == "#"))

