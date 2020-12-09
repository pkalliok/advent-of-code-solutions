
import re
from itertools import accumulate

instr_re = re.compile(r'(acc|nop|jmp) ([+-][0-9]+)')

def parse_line(line):
    try: return instr_re.match(line).groups()
    except:
        print(line)
        raise

def file_to_program(f):
    return [(op, int(arg)) for op, arg in (parse_line(line) for line in f)]

def exec_seq(prog, ip):
    while True:
        yield ip
        op, arg = prog[ip]
        ip += arg if op == 'jmp' else 1

def no_loop(seq):
    visited = set()
    for ip in seq:
        if ip in visited: return
        yield ip
        visited.add(ip)

def acc_sum(prog, seq):
    return sum(arg for op, arg in (prog[ip] for ip in seq) if op == 'acc')

if __name__ == '__main__':
    import sys
    prog = file_to_program(open(sys.argv[1]))
    print(acc_sum(prog, no_loop(exec_seq(prog, 0))))
