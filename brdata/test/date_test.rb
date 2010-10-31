# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class DateTest < ActiveSupport::TestCase
  
  # to_date
  test "Create date with traditional date format" do
    assert_equal "2007-01-02", "2007/01/02".to_date.to_s
  end
  
  test "Create date with brazilian date format" do
    assert_equal "2007-12-13", "13/12/2007".to_date.to_s
  end
  
  test "Create date with other brazilian date format" do
    assert_equal "2007-02-01", "01-02-2007".to_date.to_s
  end

  
  #to_s
  test "Date to_s with traditional format" do
    assert_equal "2007-02-01", "01/02/2007".to_date.to_s
  end
  
  #to_s_br
  test "Date to_s_br" do
    assert_equal "13/12/2007", "13/12/2007".to_date.to_s_br
  end
  
  #to_s_br when date is nil
  test "Date to_s_br when date is nil" do
    assert_equal "", nil.to_s_br
  end

  #valid?
  test "Valid when date format is traditional and valid format and valid civil" do
    assert Date.valid?("2007/01/02"), "Should be a valid date"
  end
  
  test "Valid when date format is brazilian and valid format and valid civil" do
    assert Date.valid?("13/12/2007"), "Should be a valid date"
  end

  if RUBY_VERSION < '1.9'
    # IMPORTANTE: Date#parse se comporta de forma diferente no ruby 1.9,
    # por isso esse teste não é executado no 1.9, ate que haja uma solução melhor
    test "Valid when date format is invalid" do
      assert !Date.valid?("13/12/200A"), "Should be a invalid date"
    end
  end

  test "Valid when date format is brazilian and valid format and invalid civil" do
    assert !Date.valid?("00/00/0000"), "Should be a invalid date"
  end

  test "Month names" do
    months = [
              nil,"Janeiro","Fevereiro","Março", "Abril","Maio","Junho",
              "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"
             ]
    assert_equal months, Date::MONTHNAMES
  end
	
  test "Day names" do
    days = [
            "Domingo","Segunda-Feira","Terça-Feira","Quarta-Feira",
            "Quinta-Feira","Sexta-Feira","Sábado"
           ]	
    assert_equal days, Date::DAYNAMES
  end

  test "Abbr month names" do
    abbr_months = [ 
                   nil,"Jan","Fev","Mar","Abr","Mai","Jun",
                   "Jul","Ago","Set","Out","Nov","Dez"
                  ] 
    assert_equal abbr_months,Date::ABBR_MONTHNAMES
  end

  test "Abbr day names" do
    assert_equal ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"], Date::ABBR_DAYNAMES
  end
	
  test "Date translation with strftime" do
    assert_equal "Dezembro Dez Sexta-Feira Sex", Date.parse("2008-12-05").strftime("%B %b %A %a")
  end

end
