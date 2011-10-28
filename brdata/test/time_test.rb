# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'

class TimeTest < Test::Unit::TestCase

  # to_time
  def test_create_time_with_traditional_time_format
    assert_equal "2007-01-02 01:23:00", "2007/01/02 01:23".to_time.to_s(:db)
  end

  def test_create_time_with_brazilian_time_format_without_time
    assert_equal "2007-12-13 00:00:00", "13/12/2007".to_time.to_s(:db)
  end

  def test_create_time_with_brazilian_time_format_with_time
    assert_equal "2007-12-13 01:23:00", "13/12/2007 01:23".to_time.to_s(:db)
  end

  def test_create_time_with_brazilian_time_format_with_time_with_single_number
    assert_equal "2007-02-01 01:23:00", "1/2/2007 1:23".to_time.to_s(:db)
  end


  #to_s
  def test_time_to_s_with_traditional_format
    if RUBY_VERSION < '1.9'
      assert_equal "Mon Sep 24 16:03:05 UTC 2007", "Mon Sep 24 16:03:05 UTC 2007".to_time.to_s
    else
      assert_equal "2007-09-24 16:03:05 UTC", "2007-09-24 16:03:05 UTC".to_time.to_s
    end
  end

  #to_s_br
  def test_time_to_s_br
    assert_equal "24/09/2007 16:03", "Mon Sep 24 16:03:05 UTC 2007".to_time.to_s_br
  end

  def test_month_names
    assert_equal [nil,
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro"],
      Time::MONTHNAMES
  end

  def test_days_names
    assert_equal ["Domingo",
      "Segunda-Feira",
      "Terça-Feira",
      "Quarta-Feira",
      "Quinta-Feira",
      "Sexta-Feira",
      "Sábado"],
      Time::DAYNAMES
  end

  def test_abbr_monthnames
    assert_equal [nil,
      "Jan",
      "Fev",
      "Mar",
      "Abr",
      "Mai",
      "Jun",
      "Jul",
      "Ago",
      "Set",
      "Out",
      "Nov",
      "Dez"],
      Time::ABBR_MONTHNAMES
  end

  def test_abbr_daysnames
    assert_equal ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"], Time::ABBR_DAYNAMES
  end

  def test_time_translation_with_strftime
    assert_equal "Dezembro Dez Sexta-Feira Sex", Time.parse("2008-12-05").strftime("%B %b %A %a")
  end

end
