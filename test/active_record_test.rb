require File.dirname(__FILE__) + '/test_helper'

class ActiveRecordTestable < ActiveRecord::Errors
  
  def self.default_error_messages
    @@default_error_messages
  end
  
end

class ActiveRecordTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_plugin
    errors = ActiveRecordTestable.default_error_messages
    assert_equal "não está incluído na lista", errors[:inclusion]  
    assert_equal "está reservado", errors[:exclusion]  
    assert_equal "é inválido.", errors[:invalid]  
    assert_equal "não corresponde à confirmação", errors[:confirmation]  
    assert_equal "deve ser aceito", errors[:accepted]  
    assert_equal "não pode estar vazio", errors[:empty]  
    assert_equal "não pode estar em branco", errors[:blank]  
    assert_equal "muito longo (máximo %d caracteres)", errors[:too_long]  
    assert_equal "muito curto (mínimo %d caracteres)", errors[:too_short]  
    assert_equal "de comprimento errado (deveria ter %d caracteres)", errors[:wrong_length]  
    assert_equal "já está em uso", errors[:taken]  
    assert_equal "não é um número", errors[:not_a_number]
    assert_equal "deve ser menor ou igual a %d", errors[:less_than_or_equal_to]  
  end

end
