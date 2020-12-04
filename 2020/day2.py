
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

def check_policy2(pwline):
    lb, ub, letter, pw = pwline
    return (pw[lb-1] + pw[ub-1]).count(letter) == 1

def count_correct(pwlines, pred):
    return sum(1 for pwline in pwlines if pred(pwline))

if __name__ == '__main__':
    import sys
    lines = [parse_pwline(l) for l in open(sys.argv[1])]
    print(count_correct(lines, check_policy))
    print(count_correct(lines, check_policy2))

