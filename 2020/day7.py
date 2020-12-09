
from functools import reduce
from itertools import groupby
import re

rule_re = re.compile(r'(\w+ \w+) bags contain (.*)\.')
content_re = re.compile(r'([0-9]+) (\w+ \w+) bags?')

def contain_arcs(rules):
    return ((container, amount, item)
            for container, content in
                (rule_re.match(rule).groups() for rule in rules)
            for amount, item in content_re.findall(content))

def rev_graph(arcs):
    return make_graph((v, k) for k, amount, v in arcs)

def forw_graph(arcs):
    return make_graph((k, (int(amount), v)) for k, amount, v in arcs)

def make_graph(pairs):
    g = groupby(sorted(pairs), lambda p: p[0])
    return {k: set(v for k, v in ps) for k, ps in g}

def set_flatten(sset):
    return reduce(lambda a,b: a|b, sset)

def transitive_closure(graph, start_set):
    next_set = start_set | set_flatten(graph.get(v, set()) for v in start_set)
    if start_set == next_set: return next_set
    return transitive_closure(graph, next_set)

def contained_bags_count(graph, bag):
    return 1 + sum(am * contained_bags_count(graph, contained)
            for am, contained in graph.get(bag, set()))

if __name__ == '__main__':
    import sys
    arcs = list(contain_arcs(open(sys.argv[1])))
    graph = rev_graph(arcs)
    print(len(transitive_closure(graph, graph['shiny gold'])))
    print(contained_bags_count(forw_graph(arcs), 'shiny gold')-1)

