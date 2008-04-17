require File.dirname(__FILE__) + '/test_helper'

class DateTest < Test::Unit::TestCase
  
  # feriado 
  def test_feriado_quando_feriado
    assert "25/12/2007".to_date.feriado?
  end
  
  def test_feriado_quando_nao_eh_feriado
    assert !"01/12/2007".to_date.feriado?
  end
  
  def test_feriado_quando_feriado_eh_pascoa
    assert "08/04/2007".to_date.feriado?
  end
  
  def test_feriado_quando_feriado_eh_corpus_christi
    assert "07/06/2007".to_date.feriado?
  end
  
  # pascoa
  def test_pascoa
    assert_equal "08/04/2007", "01/01/2007".to_date.pascoa.to_s_br
  end
  
  # corpus_christi
  def test_corpus_christi
    assert_equal "07/06/2007", "01/01/2007".to_date.corpus_christi.to_s_br
  end

  
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
									Date::MONTHNAMES
	end
	
	def test_days_names
		assert_equal ["Domingo",
									 "Segunda-Feira",
									 "Terça-Feira",
									 "Quarta-Feira",
									 "Quinta-Feira",
									 "Sexta-Feira",
									 "Sábado"],
									Date::DAYNAMES
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
									Date::ABBR_MONTHNAMES
  end

	def test_abbr_daysnames
		assert_equal ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"], Date::ABBR_DAYNAMES
	end
	
	def test_date_translation_with_strftime
    assert_equal "Dezembro Dez Sexta-Feira Sex", Date.parse("12/05").strftime("%B %b %A %a")
  end

end
