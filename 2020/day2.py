
import re

pwline_re = re.compile(r'^(\d+)-(\d+) (\w): (\w+)$')

def parse_pwline(pwline):
    m = pwline_re.match(pwline)
    if not m: return m
    lb, ub, letter, pw = m.groups()
    return (int(lb), int(ub), letter, pw)

def check_policy(pwline):
    lb, ub, letter, pw = pwline
    return lb <= pw.count(letter) <= ub

def count_correct(pwlines):
    return sum(1 for pwline in pwlines if check_policy(pwline))

if __name__ == '__main__':
    import sys
    print(count_correct(parse_pwline(l) for l in open(sys.argv[1])))
