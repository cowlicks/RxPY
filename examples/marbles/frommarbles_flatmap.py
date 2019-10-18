import rx3
from rx3 import operators as ops

a = rx3.cold(' ---a0---a1----------------a2-|    ')
b = rx3.cold('    ---b1---b2---|                 ')
c = rx3.cold('             ---c1---c2---|        ')
d = rx3.cold('                   -----d1---d2---|')
e1 = rx3.cold('a--b--------c-----d-------|       ')

observableLookup = {"a": a, "b": b, "c": c, "d": d}

source = e1.pipe(
    ops.flat_map(lambda value: observableLookup[value]),
    ops.do_action(lambda v: print(v)),
    )

source.run()
