require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'net/http'
require 'mocha'

class BrFormHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::FormHelper
  
  def test_radios_sexo
    radio_m = '<input id="lancamento_sexo_m" name="lancamento[sexo]" type="radio" value="M" /> Masculino'
    radio_f = '<input id="lancamento_sexo_f" name="lancamento[sexo]" type="radio" value="F" /> Feminino'
    assert_equal %(#{radio_m}\n#{radio_f}), radio_button_sexo(:lancamento, :sexo)
  end

end