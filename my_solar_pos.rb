
require 'date'
include Math
D2R = PI / 180
R2D = 180 / PI
D2PI = 6.283185307179586476925287
DAS2R = 4.848136811095359935899141e-6
DJ00 = 2_451_545.0
DJC = 36_525.0
LA = lambda do |x, a|
  a[0] +
    x * (a[1] +
    x * (a[2] +
    x * (a[3] +
    x * (a[4] +
    x * a[5]))))
end
DMA = [357.52910918, 35_999.05029113889, -0.000153667,
       3.7778e-08, -3.191667e-09, 0].freeze
DME = [280.4664576, 36_000.76982779, 0.00030328,
       1.0 / 499_310.0, 1.0 / -152_990.0, 1.0 / -19_880_000.0].freeze
DGM = [0.014506, 4612.156534, 1.3915817,
       -0.00000044, -0.000029956, -0.0000000368].freeze
DTA = [0, 2400.051336906897, 2.586222e-05, -1.7222e-08, 0, 0].freeze

def lambda_array(t, d)
  LA.call(t, d)
end

def jct(ajd)
  (ajd - DJ00) / DJC
end

def mls(ajd)
  lambda_array(jct(ajd), DME)
end

def ma(t)
  (lambda_array(t, DMA) * D2R) % D2PI
end

EQA = [1.914600, -0.004817, -0.000014, 0, 0, 0].freeze
EQA1 = [0.019993, -0.000101, 0, 0, 0, 0].freeze

def eqc(t)
  lambda_array(t, EQA) * sin(ma(t)) +
    lambda_array(t, EQA1) * sin(2 * ma(t)) +
    0.000290 * sin(3 * ma(t))
end

def tl(ajd)
  (mls(ajd) + eqc(jct(ajd))).modulo(360)
end

def omega(ajd)
  doa = [125.044555, -1934.13626197, 0.0020756, 5.76555e-07, 1.649722e-08, 0]
  lambda_array(jct(ajd), doa) * D2R
end

def epsilon(ajd)
  ed = [23.4392966666667, 0.0127778, 0.00059 / 60.0, 0, 0, 0]
  (lambda_array(jct(ajd), ed) + 0.00256 * cos(omega(ajd))) * D2R
end

def lambda(ajd)
  (tl(ajd) - 0.00569 - 0.00478 * sin(omega(ajd))) * D2R
end

def delta(ajd)
  asin(sin(epsilon(ajd)) * sin(lambda(ajd)))
end

def alpha(ajd)
  a = (atan2(-(cos(epsilon(ajd)) * sin(lambda(ajd))), -cos(lambda(ajd))) + PI)
  a += D2PI if a < 0
  a
end

def mjd(ajd)
  ajd - 2_400_000.5
end

def mjd0(ajd)
  mjd(ajd).floor
end

def t_eph(ajd)
  (mjd0(ajd) - 51_544.5) / 36_525.0
end

def ut(ajd)
  (mjd(ajd) - mjd0(ajd)) * 24.0
end

STA = [6.697374558, 1.0027379093, 0, 0, 0, 0].freeze

def theta(ajd)
  (lambda_array(ut(ajd), STA) +
  lambda_array(t_eph(ajd), DTA)) % 24
end

TUA = [0.7790572732640, 1.00273781191135448, 0, 0, 0, 0].freeze

def theta_ut1(ajd)
  anp(D2PI * lambda_array(ajd - DJ00, TUA)) * R2D
end

def anp(val)
  w = val % D2PI
  w += D2PI if w < 0
  w
end

def era00(ajd)
  t = ajd - DJ00
  f = ajd % 1.0
  anp(D2PI * (f + 0.7790572732640 +
  0.00273781191135448 * t))
end

def gmst(ajd)
  t = jct(ajd)
  anp(era00(ajd) +
  lambda_array(t, DGM) * DAS2R)
end

def lmst(ajd)
  (gmst(ajd) * R2D + @longitude).modulo(360)
end

def lst(ajd)
  (theta(ajd) * 15 + @longitude).modulo(360)
end

def lha(ajd)
  (lmst(ajd) * D2R - alpha(ajd))
end

def altitude(ajd)
  asin(sin(@latitude) * sin(delta(ajd)) +
  cos(@latitude) * cos(delta(ajd)) * cos(lha(ajd))) * R2D
end

def azimuth(ajd)
  (atan2(sin(lha(ajd)), (cos(lha(ajd)) * sin(@latitude) -
    tan(delta(ajd)) * cos(@latitude)
                        )) * R2D).round(12) + 180
end

@latitude = 41.9475 * D2R
@longitude = -88.743

# jd = DateTime.new(2017, 3, 9).jd.to_f
ajd = DateTime.now.ajd.to_f
# p ajd = DateTime.now.ajd.to_f.floor
# ajd = jd - @longitude / 360 + -10.39 / 1440
puts DateTime.jd(ajd + 0.5)

puts theta(ajd) * 15
puts gmst(ajd) * R2D
puts theta_ut1(ajd) % 360
puts lst(ajd)
# puts delta(ajd) * R2D
# puts altitude(ajd)
# puts azimuth(ajd)

loop do
  ajd = DateTime.now.ajd.to_f
  #  ajd = jd - @longitude / 360
  #  puts lst(ajd) / 15
  #  puts lmst(ajd) / 15
  #  puts theta_ut1(ajd)
  puts theta_ut1(ajd) % 360
  puts theta(ajd) * 15
  puts gmst(ajd) * R2D
  # puts lst(ajd)
  # puts altitude(ajd)
  # puts azimuth(ajd)
  sleep 1
end
