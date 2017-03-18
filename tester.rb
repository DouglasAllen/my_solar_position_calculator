#!/usr/bin/env ruby

require_relative 'my_solar_pos'

time_inc = 1.0 * 10.0
time = Time.local(2017, 3, 16, 13, 5, 0)
jds = time.to_datetime.ajd.to_f
loop do
  puts DateTime.jd(0.5 + jds).to_time.to_s + ' ' +
       (altitude0(jds) * R2D).to_s + ' ' +
       (azimuth0(jds) * R2D).to_s
  time += time_inc
  jds += time_inc / 86_400.0
  # break if DateTime.jd(0.5 + jds).to_time.day > 17
  break if azimuth0(jds) * R2D > 181
end

