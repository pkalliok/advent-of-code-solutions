
from itertools import groupby
from functools import reduce

def collect_groups(coll, sep):
    return (group for sepp, group in groupby(coll, lambda x: x == sep)
            if not sepp)

def answers_from_file(f):
    return collect_groups((l.rstrip() for l in f), '')

def intersect_answers(answers):
    return reduce(lambda a, b: set(a)&set(b), answers)

def common_answers_in_groups(groups):
    return (len(intersect_answers(answers)) for answers in groups)

if __name__ == '__main__':
    import sys
    print(sum(common_answers_in_groups(answers_from_file(open(sys.argv[1])))))
