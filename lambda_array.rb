
k = 213
t = k / 1236.85
@l4 = ->(x, d){ d[3] + x * (d[2] + x * (d[1] + x * d[0])) }
d = [0.000_000_000_73, -0.000_000_150, 0.000_154_37, 0.0, 0.0]
jde = 2_451_550.097_66 + 29.530_588_861 * k + @l4.call(t, d)
require 'date'
p DateTime.jd(jde + 0.5)
