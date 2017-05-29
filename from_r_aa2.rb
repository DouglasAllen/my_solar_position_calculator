
require 'date'
include Math
D2R = PI / 180.0
R2D = 180.0 / PI

def jc(jd)
  (jd - 2_451_545) / 36_525.0
end

def sun_gml(jd)
  D2R * ((280.46646 + jc(jd) * (36_000.76983 + jc(jd) * 0.0003032)) % 360.0)
end

def sun_gma(jd)
  D2R * (357.52911 + jc(jd) * (35_999.05029 - 0.0001537 * jc(jd)) % 360.0)
end

def eeo(jd)
  0.016708634 - jc(jd) * (0.000042037 + 0.0000001267 * jc(jd))
end

def sun_eoc(jd)
  D2R * (sin(sun_gma(jd)) * (
    1.914602 - jc(jd) * (0.004817 + 0.000014 * jc(jd))) +
    sin(2 * sun_gma(jd)) * (0.019993 - 0.000101 * jc(jd)) +
    sin(3 * sun_gma(jd)) * 0.000289)
end

def sun_tl(jd)
  (sun_eoc(jd) + sun_gml(jd)) % (PI * 2)
end

def sun_al(jd)
  (D2R * (R2D * sun_tl(jd) -
  0.00569 - 0.00478 * sin(D2R * (125.04 - 1934.136 * jc(jd))))) % 360.0
end

def mobe(jd)
  23 + (26 + ((21.448 - jc(jd) * (46.815 + jc(jd) * (0.00059 -
  jc(jd) * 0.001813)))) / 60.0) / 60.0
end

def obc(jd)
  D2R * (mobe(jd) + 0.00256 * cos(D2R * (125.04 - 1934.136 * jc(jd))))
end

def sun_dec(jd)
  asin(sin(obc(jd)) * sin(sun_al(jd))) % (PI * 2)
end

def foo_y(jd)
  tan((obc(jd) / 2.0)) * tan((obc(jd) / 2.0))
end

def eot(jd)
  (4.0 * R2D * (foo_y(jd) * sin(2.0 * sun_gml(jd)) -
  2.0 * eeo(jd) * sin(sun_gma(jd)) +
  4.0 * eeo(jd) * foo_y(jd) * sin(sun_gma(jd)) * cos(2.0 * sun_gml(jd)) -
  0.5 * foo_y(jd) * foo_y(jd) * sin(4.0 * sun_gml(jd)) -
  1.25 * eeo(jd) * eeo(jd) * sin(2.0 * sun_gma(jd))))
end

def sun_ha(jd, lat)
  R2D * acos((cos(D2R * 90.833) / (cos(D2R * lat) * cos(sun_dec(jd)))) -
  tan(D2R * lat) * tan(sun_dec(jd)))
end

def lambda(jd)
  atan2(sin(atan2(cos(obc(jd)) * sin(sun_tl(jd)),
                  cos(sun_al(jd))) * cos(obc(jd))) +
                  tan(sun_dec(jd)) * cos(obc(jd)),
        cos(atan2(cos(obc(jd)) * sin(sun_tl(jd)),
                  cos(sun_al(jd)))))
end

def beta(jd)
  asin(sin(sun_dec(jd)) * cos(obc(jd)) -
  cos(sun_dec(jd)) * sin(obc(jd)) * atan2(cos(obc(jd)) * sin(sun_tl(jd)),
                                          cos(sun_al(jd))))
end

def sun_ra(jd)
  y0 = sin(sun_tl(jd)) * cos(obc(jd)) # - tan(beta(jd)) * sin(obc(jd))
  x0 = cos(sun_tl(jd))
  (atan2(-y0, -x0) + PI) % (PI * 2)
end

def d0(jd)
  jd.floor - 2_451_545.5
end

def t0(jd)
  d0(jd) / 36_525.0
end

def jdh(jd)
  (jd % 1.0 + 0.5) * 24.0
end

def gmsa0(jd)
  (100.46061837 + 0.9856473662862001 * d0(jd) +
  t0(jd) * (t0(jd) * 0.000387933 + t0(jd) * (t0(jd) * -1.0 / 38_710_000))) % 360.0
end

def gmsa(jd)
  (gmsa0(jd) + 15.04106864025 * jdh(jd)) % 360.0
end

def gha(jd)
  (gmsa(jd) - sun_ra(jd) * R2D) % 360.0
end

def lha(jd, lon)
  (gha(jd) + lon) % 360.0
end

def azimuth(jd, lat, lon)
  (360 + R2D * atan2(-sin(lha(jd, lon)),
                     -(cos(lha(jd, lon)) * sin(D2R * lat) -
                     tan(sun_dec(jd)) * cos(D2R * lat)))) % 360.0
end

def sha(jd)
  360 - sun_ra(jd) * R2D
end

def solar_noon(jd, lon, tz)
  jd - tz / 24.0 + (720.0 - 4.0 * lon - eot(jd) + tz * 60.0) / 1440.0
end

def sunrise_time(jd, lat, lon, tz)
  solar_noon(jd, lon, tz) - sun_ha(jd, lat) * 4.0 / 1440.0
end

def sunset_time(jd, lat, lon, tz)
  solar_noon(jd, lon, tz) + sun_ha(jd, lat) * 4.0 / 1440.0
end

def sunlight_duration(jd, lat)
  (8.0 * sun_ha(jd, lat)) / 60.0
end

jd = Date.today.jd
lat = 41.9475
lon = -88.743
tz = -5

puts "#{sunlight_duration(jd, lat)} Daylight hours"
puts "#{DateTime.jd(sunrise_time(jd, lat, lon, tz)).to_time} sunrise"
puts "#{DateTime.jd(solar_noon(jd, lon, tz)).to_time} transit"
puts "#{DateTime.jd(sunset_time(jd, lat, lon, tz)).to_time} sunset"
puts "#{solar_noon(jd, lon, tz) + 0.5} transit ajd"
puts "#{gmsa0(jd)} GMS angle 00:00"
puts "#{gmsa(solar_noon(jd, lon, tz) + 0.5)} GMS angle transit"
puts "#{gha(solar_noon(jd, lon, tz) + 0.5)} GHA transit"
puts "#{sun_al(solar_noon(jd, lon, tz) + 0.5) * R2D} Apparent Longitude transit"
puts "#{sun_ra(solar_noon(jd, lon, tz) + 0.5) * R2D} Right Ascension transit"
puts "#{lha(solar_noon(jd, lon, tz) + 0.5, lon)} LHA transit"
puts "#{azimuth(sunrise_time(jd, lat, lon, tz) + 0.5, lat, lon)} AZ sunrise"
puts "#{azimuth(solar_noon(jd, lon, tz) + 0.5, lat, lon)} AZ transit"
puts
