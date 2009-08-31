# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'
require 'mocha'

class ActionViewTest < Test::Unit::TestCase
  
  include ActionView::Helpers::DateHelper
  
  def test_distance_of_time_in_words
    assert_equal "menos de um minuto", distance_of_time_in_words("Sat Sep 08 22:51:58 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "menos de 5 segundos", distance_of_time_in_words("Sat Sep 08 22:51:58 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time, true)
    assert_equal "menos de 10 segundos", distance_of_time_in_words("Sat Sep 08 22:51:50 -0300 2007".to_time, "Sat Sep 08 22:51:55 -0300 2007".to_time, true)
    assert_equal "menos de 20 segundos", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:10 -0300 2007".to_time, true)
    assert_equal "meio minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:20 -0300 2007".to_time, true)
    assert_equal "menos de um minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:40 -0300 2007".to_time, true)
    assert_equal "1 minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:52:00 -0300 2007".to_time, true)
    assert_equal "1 minuto", distance_of_time_in_words("Sat Sep 08 22:51:59 -0300 2007".to_time, "Sat Sep 08 22:52:59 -0300 2007".to_time)
    assert_equal "2 minutos", distance_of_time_in_words("Sat Sep 08 22:51:59 -0300 2007".to_time, "Sat Sep 08 22:53:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 hora", distance_of_time_in_words("Sat Sep 08 21:51:59 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 2 horas", distance_of_time_in_words("Sat Sep 08 20:51:59 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "1 dia", distance_of_time_in_words("Sat Sep 07 20:51:59 -0300 2007".to_time, "Sat Sep 08 20:51:59 -0300 2007".to_time)
    assert_equal "2 dias", distance_of_time_in_words("Sat Sep 06 20:51:59 -0300 2007".to_time, "Sat Sep 08 20:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 mês", distance_of_time_in_words("Sat Oct 06 20:51:59 -0300 2007".to_time, "Sat Sep 06 20:51:59 -0300 2007".to_time)
    assert_equal "2 meses", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2007".to_time, "Sat Sep 06 20:51:59 -0300 2007".to_time)
    assert_equal "12 meses", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Nov 06 20:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 ano", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Dec 06 20:51:59 -0300 2007".to_time)
    assert_equal "mais de 3 anos", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Dec 06 20:51:59 -0300 2009".to_time)
  end
end
