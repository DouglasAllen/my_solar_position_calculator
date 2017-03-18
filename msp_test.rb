#!/usr/bin/env ruby

require 'rubygems'
require 'test/unit'

require 'date'
require_relative 'my_solar_pos'

# doc
class TestMSP100 < Test::Unit::TestCase
  include MSP
  def setup
    @time = Time.new(2017, 3, 17, 13, 3, 12.48720407273)
    @ajd = @time.to_datetime.ajd.to_f
    @lat = 41.9475 * D2R
    @lon = -88.743 * D2R
  end

  def test_eot
    assert_equal(
      -8.170586518165058,
      eot(jct(@ajd))
    )
  end

  def test_delta
    assert_equal(
      -1.0563554611147432,
      delta(jct(@ajd)) * R2D
    )
  end

  def test_gmsa0
    assert_equal(
      86.30495562013078,
      gmsa0(@ajd) * R2D
    )
  end

  def test_gmst0
    assert_equal(
      5.753663708008719,
      gmst0(@ajd)
    )
  end

  def test_gha0
    assert_equal(
      88.74300013047555,
      gha0(@ajd) * R2D
    )
  end

  def test_lmsa0
    assert_equal(
      357.5619556201308,
      lmsa0(@ajd, @lon) * R2D
    )
  end

  def test_lmst0
    assert_equal(
      23.83746370800872,
      lmst0(@ajd, @lon)
    )
  end

  def test_lha0
    assert_equal(
      1.3047555119777226e-07,
      lha0(@ajd, @lon) * R2D
    )
  end

  def test_azimuth0
    assert_equal(
      180.00000019126725,
      azimuth0(@ajd, @lat, @lon) * R2D
    )
  end

  def test_altitude0
    assert_equal(
      46.996144538885254,
      altitude0(@ajd, @lat, @lon) * R2D
    )
  end

  def test_altitude1
    assert_equal(
      46.99614453888444,
      altitude1(@ajd, @lat, @lon) * R2D
    )
  end
end

# doc
class TestMSP200 < Test::Unit::TestCase
  include MSP
  def setup
    @time = Time.new(2017, 3, 17, 13, 3, 12.48720407273)
    @ajd = @time.to_datetime.ajd.to_f
    @lat = 41.9475 * D2R
    @lon = -88.743 * D2R
  end

  def test_mas
    assert_equal(
      72.27547131775748,
      mas(jct(@ajd)) * R2D
    )
  end

  def test_mls
    assert_equal(
      355.508732556409,
      mls(jct(@ajd)) * R2D
    )
  end

  def test_eqc
    assert_equal(
      1.8343379565406146,
      eqc(jct(@ajd)) * R2D
    )
  end

  def test_tas
    assert_equal(
      74.10980927429809,
      tas(jct(@ajd)) * R2D
    )
  end

  def test_tls
    assert_equal(
      357.3430705129496,
      tls(jct(@ajd)) * R2D
    )
  end
end

