
from functools import reduce
from itertools import groupby
import re

rule_re = re.compile(r'(\w+ \w+) bags contain (.*)\.')
content_re = re.compile(r'[0-9]+ (\w+ \w+) bags?')

def contain_pairs(rules):
    return ((container, item)
            for container, content in
                (rule_re.match(rule).groups() for rule in rules)
            for item in content_re.findall(content))

def rev_graph(pairs):
    s = sorted((v, k) for k, v in pairs)
    g = groupby(s, lambda p: p[0])
    return {k: set(v for k, v in ps) for k, ps in g}

def set_flatten(sset):
    return reduce(lambda a,b: a|b, sset)

def transitive_closure(graph, start_set):
    next_set = start_set | set_flatten(graph.get(v, set()) for v in start_set)
    if start_set == next_set: return next_set
    return transitive_closure(graph, next_set)

if __name__ == '__main__':
    import sys
    graph = rev_graph(contain_pairs(open(sys.argv[1])))
    print(len(transitive_closure(graph, graph['shiny gold'])))

