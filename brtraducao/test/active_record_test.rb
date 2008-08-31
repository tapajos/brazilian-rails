require File.dirname(__FILE__) + '/test_helper'

class ActiveRecordTestable < ActiveRecord::Errors
  
  def self.default_error_messages
    @@default_error_messages
  end
  
end

class ActiveRecordTest < Test::Unit::TestCase
  
  def test_active_record_messages
    errors = ActiveRecordTestable.default_error_messages
    assert_equal "não está incluído(a) na lista", errors[:inclusion]  
    assert_equal "é reservado(a)", errors[:exclusion]  
    assert_equal "é inválido(a)", errors[:invalid]  
    assert_equal "não corresponde à confirmação", errors[:confirmation]  
    assert_equal "deve ser aceito(a)", errors[:accepted]  
    assert_equal "deve ser preenchido(a)", errors[:empty]  
    assert_equal "deve ser preenchido(a)", errors[:blank]  
    assert_equal "deve ter até %d caractere(s)", errors[:too_long]  
    assert_equal "deve ter no mínimo %d caractere(s)", errors[:too_short]  
    assert_equal "deve ter %d caractere(s)", errors[:wrong_length]  
    assert_equal "já está em uso", errors[:taken]  
    assert_equal "não é um número", errors[:not_a_number]
    assert_equal "deve ser maior que %d", errors[:greater_than]
    assert_equal "deve ser maior ou igual a %d", errors[:greater_than_or_equal_to]
    assert_equal "deve ser igual a %d", errors[:equal_to]
    assert_equal "deve ser menor que %d", errors[:less_than]
    assert_equal "deve ser menor ou igual a %d", errors[:less_than_or_equal_to]  
    assert_equal "deve ser impar", errors[:odd]
    assert_equal "deve ser par", errors[:even]
  end

end


