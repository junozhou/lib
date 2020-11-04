s = [('yellow', 1), ('blue', 2),  ('red', 1)]
d = {}
for k, v in s:
    d.setdefault(k, v)

d.items()

#
s = [('yellow', 1), ('blue', 2), ('yellow', 3), ('blue', 4), ('red', 1)]
d = {}
for k, v in s:
    d.setdefault(k, []).append(v)

d.items()


s=[('yellow', 1), ('blue', 2),  ('red', 1)]
d = dict(s)
d
{'yellow': 1, 'blue': 2, 'red': 1}