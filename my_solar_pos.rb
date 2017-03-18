
require 'eot'
require 'date'
module MSP
  include Math
  # constants
  D2R = PI / 180
  R2D = 180 / PI
  R2T = R2D / 15
  D2PI = 6.283185307179586476925287
  DAS2R = 4.848136811095359935899141e-6
  DJ00 = 2_451_545.0
  DJC = 36_525.0
  # utility functions begin
  LA = lambda do |x, a|
    a[0] +
      x * (a[1] +
      x * (a[2] +
      x * (a[3] +
      x * (a[4] +
      x * a[5]))))
  end
  def lambda_array(t, d)
    LA.call(t, d)
  end

  def jct(ajd)
    (ajd - DJ00) / DJC
  end

  def t2ajd(t)
    t * DJC + DJ00
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

  # return radians normalized 0-2pi
  def anp(val)
    w = val % D2PI
    w += D2PI if w < 0
    w
  end

  # utility end

  # degrees mean anomaly sun array
  DMA = [357.52910918, 35_999.05029113889, -0.000153667,
         3.7778e-08, -3.191667e-09, 0].freeze
  def mas(t)
    anp(lambda_array(t, DMA) * D2R)
  end

  # true anomaly
  def tas(t)
    anp(mas(t) + eqc(t))
  end

  # degrees mean equinox or longitude array
  DME = [280.4664576, 360_007.6982779, 0.03032028,
         1.0 / 49_931, -1.0 / 15_299, -1.0 / 1_988_000].freeze
  def mls(t)
    anp(lambda_array(t / 10.0, DME) * D2R)
  end

  # true or corrected longitude sun
  def tls(t)
    anp(mls(t) + eqc(t))
  end

  # equation of center sine mean anomaly x 1
  EQ1 = [1.914600, -0.004817, -0.000014, 0, 0, 0].freeze
  def eqc_smas1(t)
    lambda_array(t, EQ1) * sin(mas(t))
  end

  # equation of center sine mean anomaly x 2
  EQ2 = [0.019993, -0.000101, 0, 0, 0, 0].freeze
  def eqc_smas2(t)
    lambda_array(t, EQ2) * sin(2 * mas(t))
  end

  # equation of center sine mean anomaly x 3
  def eqc_smas3(t)
    0.000290 * sin(3 * mas(t))
  end

  # equation of center
  def eqc(t)
    (eqc_smas1(t) + eqc_smas2(t) + eqc_smas3(t)) * D2R
  end

  # degrees omega array
  DOA = [125.044555, -1934.13626197, 0.0020756, 5.76555e-07,
         1.649722e-08, 0].freeze
  def omega(t)
    anp(lambda_array(t, DOA) * D2R)
  end

  # earth eccentric orbit array
  ECA = [0.0167086342, -0.00004203654, -0.000000126734, 0, 0, 0].freeze
  def eec(t)
    lambda_array(t, ECA)
  end

  # epsilon degree, arc min array
  EDA = [23, 26, 0, 0, 0, 0].freeze
  # epsilon arc sec array
  ESA = [21.448, -46.8150, 0.00059, -0.001813, 0, 0].freeze
  def epsilon(t)
    (EDA[0] +
     EDA[1] / 60.0 +
     lambda_array(t, ESA) / 3600.0 +
     0.00256 * cos(omega(t))) * D2R
  end

  # apparent solar longitude
  def asl(t)
    anp((tls(t) * D2R - 0.00569 - 0.00478 * sin(omega(t))) * D2R)
  end

  # solar declination
  def delta(t)
    asin(sin(epsilon(t)) * sin(tls(t)))
  end

  # solar right ascension
  def alpha(t)
    y0 = cos(epsilon(t)) * sin(tls(t))
    x0 = cos(tls(t))
    anp(atan2(y0, x0))
  end

  def delta_orbit(t)
    mas(t) - tas(t)
  end

  def delta_oblique(t)
    lambda(t) - alpha(t)
  end

  # parts of eot calc
  def y(t)
    epsilon(t) / 2.0 * epsilon(t) / 2.0
  end

  def y_sin_2_mls(t)
    y(t) * sin(2 * mls(t))
  end

  def eec_2_sin_mas(t)
    2.0 * eec(t) * sin(mas(t))
  end

  def eec_4_y_sin_mas_cos_2_mls(t)
    4.0 * eec(t) * y(t) * sin(mas(t)) * cos(2 * mls(t))
  end

  def y_y_5_sin_4_mls(t)
    0.5 * y(t) * y(t) * sin(4 * mls(t))
  end

  def eec_eec_1_25_sin_2_mas(t)
    1.25 * eec(t) * eec(t) * sin(2 * mas(t))
  end

  def eot(t)
    # delta_orbit(t) + delta_oblique(t)
    (y_sin_2_mls(t) - eec_2_sin_mas(t) +
      eec_4_y_sin_mas_cos_2_mls(t) -
      y_y_5_sin_4_mls(t) -
      eec_eec_1_25_sin_2_mas(t)) * R2D * 4.0
  end

  # earth rotation angle
  TUA = [0.7790572732640, 0.00273781191135448, 0, 0, 0, 0].freeze
  def theta_ut1(ajd)
    anp(D2PI * (ajd % 1.0 + lambda_array(ajd - DJ00, TUA)))
  end

  # arc seconds mean Greenwich angle array
  DGM = [0.014506, 4612.156534, 1.3915817,
         -0.00000044, -0.000029956, -0.0000000368].freeze
  def gmsa0(ajd)
    anp(theta_ut1(ajd) + lambda_array(jct(ajd), DGM) * DAS2R)
  end

  def gmst0(ajd)
    R2D * gmsa0(ajd) / 15
  end

  def gha0(ajd)
    anp(gmsa0(ajd) - alpha(jct(ajd)))
  end

  def lha0(ajd, lon)
    anp(gha0(ajd) + lon)
  end

  # used for sidereal angles
  DTA = [0, 2400.051336906897, 2.586222e-05, -1.7222e-08, 0, 0].freeze
  # used for sidereal time
  STA = [6.697374558, 1.0027379093, 0, 0, 0, 0].freeze
  def gmsa1(ajd)
    anp(((lambda_array(ut(ajd), STA) +
    lambda_array(t_eph(ajd), DTA)) % 24) * 15 * D2R)
  end

  def gmst1(ajd)
    R2D * gmsa1(ajd) / 15
  end

  def gha1(ajd)
    anp(gmsa1(ajd) - alpha(jct(ajd)))
  end

  def lmsa0(ajd, lon)
    anp(gmsa0(ajd) + lon)
  end

  def lmst0(ajd, lon)
    R2D * lmsa0(ajd, lon) / 15
  end

  def cos_lha0(ajd, lon)
    cos(lha0(ajd, lon))
  end

  def sin_lha0(ajd, lon)
    sin(lha0(ajd, lon))
  end

  def lmsa1(ajd, lon)
    anp((gmsa1(ajd) + lon))
  end

  def lmst1(ajd, lon)
    R2D * lmsa1(ajd, lon) / 15
  end

  def lha1(ajd, lon)
    anp(lmsa1(ajd, lon) - alpha(jct(ajd)))
  end

  def cos_lha1(ajd, lon)
    cos(lha1(ajd, lon))
  end

  def sin_lha1(ajd, lon)
    sin(lha1(ajd, lon))
  end

  def cos_lat(lat)
    cos(lat)
  end

  def sin_lat(lat)
    sin(lat)
  end

  def cos_delta(ajd)
    cos(delta(jct(ajd)))
  end

  def sin_delta(ajd)
    sin(delta(jct(ajd)))
  end

  def tan_delta(ajd)
    tan(delta(jct(ajd)))
  end

  def altitude0(ajd, lat, lon)
    asin(sin_lat(lat) * sin_delta(ajd) +
    cos_lat(lat) * cos_delta(ajd) * cos_lha0(ajd, lon))
  end

  def azimuth0(ajd, lat, lon)
    anp(atan2(sin_lha0(ajd, lon), cos_lha0(ajd, lon) * sin_lat(lat) -
            tan_delta(ajd) * cos_lat(lat)) - PI)
  end

  def altitude1(ajd, lat, lon)
    asin(sin_lat(lat) * sin_delta(ajd) +
    cos_lat(lat) * cos_delta(ajd) * cos_lha1(ajd, lon))
  end

  def azimuth1(ajd, lat, lon)
    anp(atan2(sin_lha1(ajd, lon), cos_lha1(ajd, lon) * sin_lat(lat) -
            tan_delta(ajd) * cos_lat(lat)) - PI)
  end
end

if __FILE__ == $PROGRAM_NAME
  include MSP
  @lat = 41.9475 * D2R
  @lon = -88.743 * D2R
  # loop do

  puts Time.now.localtime
  ajd = Time.now.localtime.to_datetime.ajd.to_f
  gmsa = gmsa0(ajd) * R2D
  gha = gha0(ajd) * R2D
  tls = tls(jct(ajd)) * R2D
  ra = alpha(jct(ajd)) * R2D
  lha = lha0(ajd, @lon) * R2D
  puts gmsa.to_s
  puts gha.to_s
  puts tls.to_s
  puts ra.to_s
  puts lha.to_s
  sleep 0.8
  # end
end
