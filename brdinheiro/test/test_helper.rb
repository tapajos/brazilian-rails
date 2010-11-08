ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require 'rails/test_help'
require "brdinheiro"

private
def tornar_metodos_publicos(clazz)
  clazz.class_eval do
    private_instance_methods.each { |instance_method| public instance_method }
    private_methods.each { |method| public_class_method method }
  end
end
  
def verifica_se_transforma_em_string_corretamente(quantia_esperada, quantia)
  assert_equal quantia_esperada, @dinheiro.transforma_em_string_que_represente_a_quantia(quantia)
end
  
def verifica_decimal(esperado, quantia = esperado)
  assert_equal esperado, @dinheiro.decimal("." + quantia)
  assert_equal esperado, @dinheiro.decimal("," + quantia)
  assert_equal esperado, @dinheiro.decimal(quantia) if quantia.blank?
end

def verifica_se_quantia_respeita_formato(quantia)
  formatos_validos(quantia).each do |quantia_str| 
    assert 1.real.quantia_respeita_formato?(quantia_str), "O sistema deveria considerar o quantia '#{quantia_str}' dentro do formato valido."
  end
end

def formatos_validos(quantia)
  formatos_validos = []
  quantias_validas(quantia).each do |quantia|
    formatos_validos << quantia
    [ "R$", "r$" ].each do |simbolo|
      [ "", " ", "     " ].each do |espacos|
        formatos_validos << "#{simbolo}#{espacos}#{quantia}"
      end
    end
  end
  formatos_validos
end

def quantias_validas(quantia)
  return [quantia] if [ ".", "," ].include?(quantia[0..0])
  [ quantia, "-#{quantia}" ]
end

def verifica_se_cria_dinheiro_para(quantia)
  assert quantia.para_dinheiro.kind_of?(Dinheiro)
end

