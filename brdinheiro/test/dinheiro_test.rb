require File.dirname(__FILE__) + '/test_helper'

class DinheiroTest < Test::Unit::TestCase

  CONTABIL = { "(2,00)" =>    -2,
                 "2,00" =>     2,    
                 "0,00" =>     0,
                 "0,32" =>  0.32,
               "(0,01)" => -0.01 }
  
  REAL_CONTABIL = { "R$ (1,00)" => -1,
                    "R$ (0,12)" => -0.12,
                      "R$ 1,00" => 1,
                      "R$ 1,00" => 1,
                      "R$ 1,00" => 1,
                      "R$ 0,00" => 0 }

  SOMA = {      0.real =>    0.real + 0.real,
                1.real =>    0.real + 1.real,
                1.real =>    1.real + 0.real,
               2.reais =>    1.real + 1.real,
               2.reais =>   0.real + 2.reais,
               2.reais =>   2.reais + 0.real,
                0.real =>   2.real + -2.real,
                0.real =>   0.real + BigDecimal.new("0"),
              0.3.real =>  0.real + 0.3.real,
             -0.3.real => 0.real + -0.3.real,
            -0.03.real =>     0 + -0.03.real,
            -0.03.real =>     0.real + -0.03,   
            -1.03.real =>    -1.real + -0.03,
            -1.03.real =>    -1.real + BigDecimal.new("-0.03") }

  SUBTRACAO = {     0.real =>       0.real - 0.real,
                   -1.real =>       0.real - 1.real,
                    1.real =>       1.real - 0.real,
                    0.real =>       1.real - 1.real,
                  -2.reais =>      0.real - 2.reais,
                   2.reais =>      2.reais - 0.real,
                  -4.reais =>    -2.reais - 2.reais,
                  0.3.real =>     0.3.real - 0.real,
                 0.03.real =>    0.03.real - 0.real,
                 0.03.real => 0.06.real - 0.03.real,
                -0.03.real =>         0 - 0.03.real,
                -0.03.real =>         0.real - 0.03,    
                -1.03.real =>        -1.real - 0.03, 
                -1.03.real =>        -1.real - BigDecimal.new("0.03") }
                
  MULTIPLICACAO = {    0.real =>        0.real * 0,
                       0.real =>        0.real * 1,
                       0.real =>       0.real * -1,
                       1.real =>        1.real * 1,
                       10.real =>        10.real * 1,
                       100.real =>        100.real * 1,
                       1000.real =>        1000.real * 1,
                       1.real =>      -1.real * -1,
                      -1.real =>       1.real * -1,
                      -1.real =>       -1.real * 1,
                     0.1.real =>      1.real * 0.1,
                    0.01.real =>     1.real * 0.01,
                    0.01.real =>    1.real * 0.009,
                    0.01.real =>    1.real * 0.005,
                    0.00.real =>   1.real * 0.0049,
                     0.1.real =>      0.1.real * 1,
                    0.01.real =>     0.01.real * 1,
                    0.01.real =>    0.009.real * 1,
                    0.00.real =>  0.00049.real * 1,
                       0.real =>   0.real * 0.real,
                       0.real =>   0.real * BigDecimal("0"),
                       1.real =>   1.real * 1.real,
                       1.real =>   1.real * BigDecimal("1"),
                       1.real => 0.5.real * 2.real,
                       1.real => 0.5.real * BigDecimal("2"),
                       1.real =>        1 * 1.real,
                      -1.real =>       -1 * 1.real,
                       1.real =>      -1 * -1.real,
                    0.01.real =>     0.01 * 1.real,
                    0.01.real =>   1.real * BigDecimal("0.01"),
                    0.01.real =>   BigDecimal("0.01") * 1.real }
                    
  DIVISAO = { 
            Dinheiro.new(0.33)  =>  Dinheiro.new(1) / 3,
            Dinheiro.new(33.33) =>  Dinheiro.new(100) / 3,
            Dinheiro.new(50.00) =>  Dinheiro.new(100) / 2,
            Dinheiro.new(0.25)  =>  Dinheiro.new(0.5) / 2,
            Dinheiro.new(0.17)  =>  Dinheiro.new(0.5) / 3,
            Dinheiro.new(0.33)  =>  Dinheiro.new(0.33) / 1
            }
                                                    
  PARCELAS = { 
            [Dinheiro.new(0.33), Dinheiro.new(0.33), Dinheiro.new(0.34)] =>    Dinheiro.new(1).parcelar(3),
         [Dinheiro.new(33.33), Dinheiro.new(33.33), Dinheiro.new(33.34)] =>  Dinheiro.new(100).parcelar(3),
                                 [Dinheiro.new(50.00), Dinheiro.new(50)] =>  Dinheiro.new(100).parcelar(2),
                                [Dinheiro.new(0.25), Dinheiro.new(0.25)] =>  Dinheiro.new(0.5).parcelar(2),
             [Dinheiro.new(0.16), Dinheiro.new(0.17),Dinheiro.new(0.17)] =>  Dinheiro.new(0.5).parcelar(3),
                                                    [Dinheiro.new(0.33)] => Dinheiro.new(0.33).parcelar(1),
                                                    [Dinheiro.new(0.33)] => Dinheiro.new(0.33).parcelar(1),
                                                    }                    
                    
                    
  QUANTIA_COM_FORMATO_VALIDO =  [                   "1211",
                                                   "1211.",
                                                  "1211.0",
                                                 "1211.23",
                                                 "1211,23",
                                                   "1.211",
                                                "1.211,00",
                                                "1.211,01",
                                                 "1.211,1",
                                                  "1.211,",
                                                      "1,",
                                                     "12,",
                                         "32349898989912,",
                                     "32.349.898.989.912,",
                                    "32.349.898.989.912,1",
                                   "32.349.898.989.912,12",
                                                       "1",
                                                    "1.00",
                                                    "1.01",
                                                     "1.1",
                                                      "1.",
                                                      ".1",
                                                     ".12",
                                                    "0.12",
                                                    "1.12",
                                                   "12.12",
                                                   "12.12",
                                                  "123.12",
                                                "1,234.12",
                                               "12,234.12",
                                              "123,234.12",
                                            "2,123,234.12",
                                                      ",1",
                                                     ",11",
                                                     ",01",
                                                    "0,01" ]
  QUANTIA_COM_FORMATO_INVALIDO = [    'teste',
                                   '12,123,99',
                                   '12.123.99',
                                    '1,123,99',
                                   '1212,39.90' ]
                                                    
  COMPARACAO = [  1.real < 2.reais,
                  1.real <= 2.reais,
                  2.real  >  1.real,
                  2.real >=  1.real,
                  1.real ==  1.real,
                  1.real >=  1.real,
                  1.real <=  1.real ]

  COMPARACAO_COM_ESCALAR = [  1.real  < 2.00,
                              1.real <= 2.00,
                              2.real  > 1.00,
                              2.real >= 1.00,
                              1.real == 1.00,
                              1.real >= 1.00,
                              1.real <= 1.00 ]
                                                      
  ARREDONDAMENTO =  { 23049 =>         230.49, 
                      23049 => 230.4949999999,
                      23050 =>        230.495 }
  
  PONTO_NO_MILHAR = {  "234.175.211"  =>   "234175211",
                                 ""   =>            "",
                                "1"   =>           "1",
                               "12"   =>          "12",
                              "123"   =>         "123",
                            "1.234"   =>        "1234",
                           "12.345"   =>       "12345",
                          "123.456"   =>      "123456",
                      "123.112.211"   =>   "123112211",
                        "1.234.567"   =>     "1234567" }

  QUANTIA_VALIDA = {       "0,00"  => 	           0  ,
                           "0,00"  =>	           0.0  ,
                           "0,00"  =>	            "0" ,
                           "0,00"  =>	         "0,00" ,
                           "1,00"  =>	             1  ,
                           "1,03"  =>	          1.03  ,
                           "1,03"  =>	         "1,03" ,
                           "0,03"  =>	          ",03" ,
                           "0,30"  =>	           ",3" ,
                           "0,03"  =>	          ".03" ,
                           "0,30"  =>	           ".3" ,
                          "-0,30"  =>	          -0.3  ,
                          "-0,03"  =>	         -0.03  ,
                           "1,00"  =>	         "1,00" ,
                          "-1,00"  =>	            -1  ,
                          "-1,00"  =>	          -1.0  ,
                          "-1,00"  =>	           "-1" ,
                          "-1,00"  =>	        "-1,00" ,
                          "-2,30"  =>	        "-2,30" ,
                           "2,30"  =>	         "2,30" ,
                           "2,30"  =>	          2.30  ,
                           "2,30"  =>	           2.3  ,
                       "1.211,00"  =>      	"1211,00" , 
                       "1.211,01"  =>       "1211,01" , 
                       "1.211,50"  =>        "1211,5" , 
                       "1.211,00"  =>	        "1211," , 
                       "1.211,00"  =>	         "1211" ,
                       "1.211,00"  =>	      "1211.00" ,      
                       "1.211,01"  =>	      "1211.01" ,      
                       "1.211,20"  =>	       "1211.2" ,      
                       "1.211,00"  =>	        "1211." ,
                       "1.211,00"  =>	         "1211" ,
                       "1.211,00"  =>	        "1.211" ,
                 "123.112.211,35"  =>	 "123112211,35" ,      
                "-123.112.211,35"  =>	"-123112211,35" ,          
                 "123.112.211,35"  =>	"+123112211,35" }
  
  PARTE_INTEIRA = [ -1, -123112211, 0, 1, 12344545 ]
  
  
  def setup
    tornar_metodos_publicos Dinheiro
    @dinheiro = 1.real
  end

  def testa_se_cria_dinheiro_a_partir_de_quantias_validos
    QUANTIA_VALIDA.each do |esperado, quantia| 
      assert_equal esperado, Dinheiro.new(quantia).to_s, "Deveria ter vindo o quantia: #{esperado} quando recebeu #{quantia}"
    end
  end
  
  # coloca_ponto_no_milhar
  def testa_se_coloca_ponto_no_milhar
    PONTO_NO_MILHAR.each do |esperado, quantia| 
      { esperado       =>     quantia,
        "-#{esperado}" => "-#{quantia}" }.each do |esperado, quantia| 
          assert_equal esperado, @dinheiro.inteiro_com_milhar(quantia) 
      end
    end
  end
  
  def testa_to_s
    assert_equal "1,00", Dinheiro.new(1).to_s
    assert_equal "1.000,00", Dinheiro.new(1000).to_s
  end
  
  # real
  def testa_real_nao_eh_dinheiro
    assert_kind_of(Dinheiro, 1.real)
  end
  
  def testa_real_eh_dinheiro
    assert_kind_of(Dinheiro, Dinheiro.new(1).real)
  end
  
  def testa_real_contabil
    REAL_CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).real_contabil }
  end  
  
  def testa_reais_contabeis
    REAL_CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).reais_contabeis }
  end  
  
  # reais
  def testa_reais
    assert_equal Dinheiro.new("2,00"), Dinheiro.new(2).reais
  end
  
  def testa_contabil
    CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).contabil }
  end 

  # real_formatado
  def test_real_formatado
    assert_equal "R$ 2,00", Dinheiro.new(2).real_formatado
  end
  
  # ==
  def testa_igualdade
    assert_equal Dinheiro.new(1), Dinheiro.new(1)
  end
  
  def testa_igualdade_quando_passa_possivel_dinheiro
    assert_equal Dinheiro.new(1), 1.0
  end
  
  def testa_igualdade_quando_passa_algo_que_nao_seja_dinheiro
    assert_equal false, Dinheiro.new(1) == 'salario'
  end
  
  # / (divisao)
  def testa_divisao
    DIVISAO.each { |parcelas, divisao| assert_equal parcelas, divisao }
  end
  
  def testa_divisao_por_zero
    assert_raise(ZeroDivisionError) { 1.real / 0 }
  end
  
  def testa_divisao_por_algo_que_nao_seja_um_escalar
    assert_raise(DivisaPorNaoEscalarError) { 10.reais / 2.reais }
  end

  # parcelar
  def testa_parcelar
    PARCELAS.each { |parcelas, divisao| assert_equal parcelas, divisao }
  end
  
  def testa_parcelar_por_zero
    assert_raise(ZeroDivisionError) { 1.real.parcelar 0 }
  end
  
  def testa_parcelar_por_algo_que_nao_seja_um_escalar
    assert_raise(DivisaPorNaoEscalarError) { 10.reais.parcelar(2.reais) }
  end
  
  # initialize
  def testa_se_cria_dinheiro_a_partir_de_float
    verifica_se_cria_dinheiro_para 1.0
  end 
  
  def testa_se_cria_dinheiro_a_partir_de_fixnum
    verifica_se_cria_dinheiro_para 1
  end 
  
  def testa_se_cria_dinheiro_a_partir_de_bigdecimal
    verifica_se_cria_dinheiro_para BigDecimal.new("1")
  end 

  def testa_se_cria_dinheiro_a_partir_de_string
    verifica_se_cria_dinheiro_para "1"
  end 
  
  def testa_se_rejeita_criacao_de_dinheiro_a_partir_de_string_invalida
    QUANTIA_COM_FORMATO_INVALIDO.each do |quantia| 
      assert_raise DinheiroInvalidoError, "Deveria ter rejeitado [#{quantia}]" do
        Dinheiro.new quantia
      end
    end
  end
  
  # + (soma)
  def testa_soma
    SOMA.each{ |esperado, soma| assert_equal esperado, soma }
  end  
  
  # - (subtracao)
  def testa_subtracao
    SUBTRACAO.each { |esperado, subtracao| assert_equal esperado, subtracao }
  end
  
  # * (multiplicacao)
  def testa_multiplicacao
    MULTIPLICACAO.each { |esperado, multiplicacao| assert_equal esperado, multiplicacao }  
  end
  
  # quantia_de
  def testa_quantia_de
    assert_equal 0, @dinheiro.quantia_de(0.real)
    assert_equal 0, @dinheiro.quantia_de(0)
  end

  #por_extenso
  def testa_por_extenso
    assert_equal 'um real', 1.real.por_extenso
    assert_equal 'um centavo', (0.01).real.por_extenso
    assert_equal 'cem reais', 100.real.por_extenso
    assert_equal 'cem reais e um centavo', (100.01).real.por_extenso
  end

  #por_extenso_em_reais
  def testa_por_extenso_em_reais
    assert_equal 'um real', 1.real.por_extenso_em_reais
    assert_equal 'um centavo', (0.01).real.por_extenso_em_reais
    assert_equal 'cem reais', 100.real.por_extenso_em_reais
    assert_equal 'cem reais e um centavo', (100.01).real.por_extenso_em_reais
  end

  def testa_por_extenso_negativo
    assert_equal 'um real negativo', -1.real.por_extenso_em_reais
    assert_equal 'um centavo negativo', (-0.01).real.por_extenso_em_reais
    assert_equal 'cem reais negativos', -100.real.por_extenso_em_reais
    assert_equal 'cem reais e um centavo negativos', (-100.01).real.por_extenso_em_reais
    assert_equal 'cento e dez reais negativos', (-110).real.por_extenso_em_reais
    assert_equal 'vinte e dois reais negativos', -22.reais.por_extenso
    assert_not_equal 'vinte e dois centavos negativos', -22.reais.por_extenso
    assert_not_equal 'vinte e dois centavos', -22.reais.por_extenso
  end

  # to_f
  def testa_to_f
    assert_equal 2.30, 2.30.real.to_f
    assert_equal 1000, 1000.real.to_f
  end
  
  # quantia_respeita_formato?
  def testa_se_quantia_respeita_formato
    QUANTIA_COM_FORMATO_VALIDO.each { |quantia| verifica_se_quantia_respeita_formato quantia }
  end
  
  # >, <, == (ordenacao)
  def testa_comparacao_entre_dinheiro
    COMPARACAO.each { |comparacao| assert comparacao }
  end
  
  def testa_comparacao_entre_possivel_dinheiro
    COMPARACAO_COM_ESCALAR.each { |comparacao_com_escalar| assert comparacao_com_escalar }
  end
  
  # decimal
  def testa_decimal_quando_todas_as_casas_estao_preenchidas
    verifica_decimal("12")
  end
  
  def testa_decimal_quando_apenas_uma_das_casas_esta_preenchida
    verifica_decimal("10", "1")
  end
  
  def testa_decimal_quando_nenhuma_das_casas_esta_preenchida
    verifica_decimal("00", "")
  end
  
  def testa_se_transforma_em_string_que_represente_a_quantia_quando_tem_tres_digitos
    verifica_se_transforma_em_string_corretamente "1.23", 123
  end

  def testa_se_transforma_em_string_que_represente_a_quantia_quando_tem_dois_digitos    
    verifica_se_transforma_em_string_corretamente "0.12", 12
  end

  def testa_se_transforma_em_string_que_represente_a_quantia_quando_tem_um_digito
    verifica_se_transforma_em_string_corretamente "0.03", 3
  end

  def testa_se_transforma_em_string_para_valores_especiais
    verifica_se_transforma_em_string_corretamente "-123112211.00", -12311221100          
  end

  # parte_inteira
  def testa_parte_inteira
    PARTE_INTEIRA.each { |quantia| assert_equal "#{quantia}", Dinheiro.new(quantia).parte_inteira }
  end
  
  def testa_se_arredonda_valores_corretamente
    ARREDONDAMENTO.each do |esperado, quantia| 
      assert_equal esperado, Dinheiro.new(quantia).quantia, "Deveria retornar #{esperado} para #{quantia}"
    end
  end
  
  def testa_se_valor_decimal_cria_o_big_decimal_corretamente
    assert_equal BigDecimal.new("1234.56"), Dinheiro.new("1234,56").valor_decimal
  end

  def testa_soma_de_dinheiro_com_big_decimal
    assert_equal Dinheiro.new(200), BigDecimal.new("100").reais + "100".reais
  end
  
  def testa_zero_quando_eh_zero
    assert Dinheiro.new(0).zero?
  end
  
  def testa_zero_quando_nao_eh_zero
    assert !Dinheiro.new(1).zero?
  end
  
  private
  
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
  
end
