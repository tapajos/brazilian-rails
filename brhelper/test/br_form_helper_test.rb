# encoding: UTF-8
require "test_helper"

class BrFormHelperTest < ActiveSupport::TestCase

  test "Radios Sexo" do
    radio_m = '<input id="lancamento_sexo_m" name="lancamento[sexo]" type="radio" value="M" /> Masculino'
    radio_f = '<input id="lancamento_sexo_f" name="lancamento[sexo]" type="radio" value="F" /> Feminino'
    assert_equal %(#{radio_m}\n#{radio_f}), radio_button_sexo(:lancamento, :sexo)
  end
end
