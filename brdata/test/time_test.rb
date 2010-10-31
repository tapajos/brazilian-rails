# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class TimeTest < ActiveSupport::TestCase
  
  # to_time
  test "Create time with traditional time format" do
    assert_equal "2007-01-02 01:23:00", "2007/01/02 01:23".to_time.to_s(:db)    
  end
  
  test "Create time with brazilian time format without time" do
    assert_equal "2007-12-13 00:00:00", "13/12/2007".to_time.to_s(:db)
  end

  test "Create time with brazilian time format with time" do
    assert_equal "2007-12-13 01:23:00", "13/12/2007 01:23".to_time.to_s(:db)
  end

  test "Create time with brazilian time format with time with single number" do
    assert_equal "2007-02-01 01:23:00", "1/2/2007 1:23".to_time.to_s(:db)
  end
  
  #to_s
  test "Time with to_s and traditional format" do
    if RUBY_VERSION < '1.9'
      assert_equal "Mon Sep 24 16:03:05 UTC 2007", "Mon Sep 24 16:03:05 UTC 2007".to_time.to_s
    else
      assert_equal "2007-09-24 16:03:05 UTC", "2007-09-24 16:03:05 UTC".to_time.to_s
    end
  end
  
  #to_s_br
  test "Time to_s_br" do
    assert_equal "24/09/2007 16:03", "Mon Sep 24 16:03:05 UTC 2007".to_time.to_s_br
  end
  
  test "Month names" do
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
	
  test "Day names" do
    assert_equal ["Domingo",
      "Segunda-Feira",
      "Terça-Feira",
      "Quarta-Feira",
      "Quinta-Feira",
      "Sexta-Feira",
      "Sábado"],
      Time::DAYNAMES
  end

  test "Abbr month names" do
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

  test "Abbr day names" do
    assert_equal ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"], Time::ABBR_DAYNAMES
  end
  
  test "Time translation with strftime" do
    assert_equal "Dezembro Dez Sexta-Feira Sex", Time.parse("2008-12-05").strftime("%B %b %A %a")
  end

end
