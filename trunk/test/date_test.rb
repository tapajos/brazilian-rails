require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + "/../lib/date_portuguese")

class DateTest < Test::Unit::TestCase
  
  # to_date
  def test_create_date_with_traditional_date_format
    assert_equal "2007-01-02", "2007/01/02".to_date.to_s
  end
  
  def test_create_date_with_brazilian_date_format
    assert_equal "2007-12-13", "13/12/2007".to_date.to_s
  end
  
  def test_create_date_with_other_brazilian_date_format
    assert_equal "2007-02-01", "01-02-2007".to_date.to_s
  end

  
  #to_s
  def test_date_to_s_with_traditional_format
    assert_equal "2007-02-01", "01/02/2007".to_date.to_s
  end
  
  def test_date_to_s_with_brazilian_format
    assert_equal "01/02/2007", "01/02/2007".to_date.to_s("BR")
  end
  
  def test_date_to_s_with_brazilian_format
    locale = "br"
    assert_equal "01/02/2007", "01/02/2007".to_date.to_s(locale)
  end
  
  #to_s_br
  def test_date_to_s_br
    assert_equal "13/12/2007", "13/12/2007".to_date.to_s_br
  end
  
  #valid?
  def test_valid_when_date_format_is_traditional_and_valid_format_and_valid_civil
    assert Date.valid?("2007/01/02"), "Should be a valid date"
  end
  
  def test_valid_when_date_format_is_brazilian_and_valid_format_and_valid_civil
    assert Date.valid?("13/12/2007"), "Should be a valid date"
  end

  def test_valid_when_date_format_is_invalid
    assert !Date.valid?("13/12/200A"), "Should be a invalid date"
  end

  def test_valid_when_date_format_is_brazilian_and_valid_format_and_invalid_civil
    assert !Date.valid?("00/00/0000"), "Should be a invalid date"
  end
  
end
