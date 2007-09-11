require File.expand_path(File.dirname(__FILE__) + '/test_helper')
require File.expand_path(File.dirname(__FILE__) + "/../init")
require File.expand_path(File.dirname(__FILE__) + "/../lib/dinheiro")
require File.expand_path(File.dirname(__FILE__) + "/../lib/dinheiro_util")
require File.expand_path(File.dirname(__FILE__) + "/../lib/excecoes")


class DinheiroTest < Test::Unit::TestCase
  
  def setup
    tornar_metodos_publicos Dinheiro
    @dinheiro = 1.real
  end

  def testa_se_cria_dinheiro_a_partir_de_quantias_validos
    [ [         "0,00"  ,             0  ],
    [           "0,00"  ,           0.0  ],
    [           "0,00"  ,            "0" ],
    [           "0,00"  ,         "0,00" ],
    [           "1,00"  ,             1  ],
    [           "1,03"  ,          1.03  ],
    [           "1,03"  ,         "1,03" ],
    [           "0,03"  ,          ",03" ],
    [           "0,30"  ,           ",3" ],
    [           "0,03"  ,          ".03" ],
    [           "0,30"  ,           ".3" ],
    [          "-0,30"  ,          -0.3  ],
    [          "-0,03"  ,         -0.03  ],
    [           "1,00"  ,         "1,00" ],
    [          "-1,00"  ,            -1  ],
    [          "-1,00"  ,          -1.0  ],
    [          "-1,00"  ,           "-1" ],
    [          "-1,00"  ,        "-1,00" ],
    [          "-2,30"  ,        "-2,30" ],
    [           "2,30"  ,         "2,30" ],
    [           "2,30"  ,          2.30  ],
    [           "2,30"  ,           2.3  ],
    [       "1.211,00"	,      "1211,00" ], 
    [       "1.211,01"	,      "1211,01" ], 
    [       "1.211,50"	,       "1211,5" ], 
    [       "1.211,00"  ,        "1211," ], 
    [       "1.211,00"  ,         "1211" ],
    [       "1.211,00"  ,      "1211.00" ],      
    [       "1.211,01"  ,      "1211.01" ],      
    [       "1.211,20"  ,       "1211.2" ],      
    [       "1.211,00"  ,        "1211." ],
    [       "1.211,00"  ,         "1211" ],
    [       "1.211,00"  ,        "1.211" ],
    [ "123.112.211,35"  , "123112211,35" ],      
    ["-123.112.211,35"  ,"-123112211,35" ],          
    [ "123.112.211,35"  ,"+123112211,35" ],              
    ].each { |quantia| verifica_se_aceita_quantia_valida quantia[0], quantia[1]  }
  end
  
  # coloca_ponto_no_milhar
  def testa_se_coloca_ponto_no_milhar
    [ ["234.175.211"        ,   "234175211" ],
    [                ""   ,            "" ],
    [               "1"   ,           "1" ],
    [              "12"   ,          "12" ],
    [             "123"   ,         "123" ],
    [           "1.234"   ,        "1234" ],
    [          "12.345"   ,       "12345" ],
    [         "123.456"   ,      "123456" ],
    [     "123.112.211"   ,   "123112211" ],
    # [    "-123.112.211"   ,  "-123112211" ],
    [       "1.234.567"   ,     "1234567" ] ].each { |par_quantia_retorno| verifica_se_coloca_ponto_no_milhar par_quantia_retorno[0],par_quantia_retorno[1] }
  end
  
  # real
  def testa_real
    assert_equal "R$ 1,00", Dinheiro.new(1).real
  end
  
  def testa_real_contabil
    assert_equal "R$ (1,00)", Dinheiro.new(-1).real_contabil
    assert_equal "R$ (0,12)", Dinheiro.new(-0.12).real_contabil
    assert_equal "R$ 1,00", Dinheiro.new(1).real_contabil
    assert_equal "R$ 1,00", "1".real_contabil
    assert_equal "R$ 1,00", "1".real_contabil
    assert_equal "R$ 0,00", "0".real_contabil
  end  
  
  def testa_reais_contabeis
    assert_equal "R$ (2,00)", Dinheiro.new(-2).reais_contabeis
    assert_equal "R$ 2,00", Dinheiro.new(2).reais_contabeis    
    assert_equal "R$ 0,00", "0".reais_contabeis
  end  
  
  # reais
  def testa_reais
    assert_equal "R$ 2,00", Dinheiro.new(2).reais
  end
  
  def testa_contabil
    assert_equal "(2,00)", Dinheiro.new(-2).contabil
    assert_equal "2,00", Dinheiro.new(2).contabil    
    assert_equal "0,00", Dinheiro.new(0).contabil
  end  
  
  
  # ==
  def testa_igualdade
    um_real = Dinheiro.new(1)
    outro_real = Dinheiro.new(1)
    assert_equal um_real, outro_real
  end
  
  def testa_igualdade_quando_passa_possivel_dinheiro
    um_real = Dinheiro.new(1)
    assert_equal um_real, 1.0
  end
  
  # / (divisao/parcelamento)
  def testa_divisao
    assert_equal [Dinheiro.new(0.33), Dinheiro.new(0.33), Dinheiro.new(0.34)], Dinheiro.new(1)/3
    assert_equal [Dinheiro.new(33.33), Dinheiro.new(33.33), Dinheiro.new(33.34)], Dinheiro.new(100)/3
    assert_equal [Dinheiro.new(50.00), Dinheiro.new(50)], Dinheiro.new(100)/2
    assert_equal [Dinheiro.new(0.25), Dinheiro.new(0.25)], Dinheiro.new(0.5)/2
    assert_equal [Dinheiro.new(0.16), Dinheiro.new(0.16),Dinheiro.new(0.18)], Dinheiro.new(0.5)/3
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
    [ 'teste', '12,123,99', '12.123.99', '1,123,99', '1212,39.90' ].each do |quantia| 
      verifica_se_rejeita_criacao_de_dinheiro_a_partir_de_string_invalida quantia     
    end
  end
  
  # + (soma)
  def testa_soma
    assert_equal 0.real, 0.real + 0.real
    assert_equal 1.real, 0.real + 1.real
    assert_equal 1.real, 1.real + 0.real
    assert_equal 2.reais, 1.real + 1.real
    assert_equal 2.reais, 0.real + 2.reais
    assert_equal 2.reais, 2.reais + 0.real
    assert_equal 0.real, 2.real + -2.real
    assert_equal 0.3.real, 0.real + 0.3.real
    assert_equal -0.3.real, 0.real + -0.3.real
    assert_equal -0.03.real, 0 + -0.03.real
    assert_equal -0.03.real, 0.real + -0.03    
    assert_equal -1.03.real, -1.real + -0.03    
  end  
  
  # - (subtracao)
  def testa_subtracao
    assert_equal 0.real, 0.real - 0.real
    assert_equal -1.real, 0.real - 1.real
    assert_equal 1.real, 1.real - 0.real
    assert_equal 0.real, 1.real - 1.real
    assert_equal -2.reais, 0.real - 2.reais
    assert_equal 2.reais, 2.reais - 0.real
    assert_equal -4.reais, -2.reais - 2.reais
    assert_equal 0.3.real, 0.3.real - 0.real
    assert_equal 0.03.real, 0.03.real - 0.real
    assert_equal 0.03.real, 0.06.real - 0.03.real
    assert_equal -0.03.real, 0 - 0.03.real
    assert_equal -0.03.real, 0.real - 0.03    
    assert_equal -1.03.real, -1.real - 0.03    
  end
  
  # * (multiplicacao)
  def testa_multiplicacao
    { 0.real      =>      0.real * 0,
      0.real      =>      0.real * 1,
      0.real      =>      0.real * -1,
      1.real      =>      1.real * 1,
      1.real      =>      -1.real * -1,
      -1.real      =>      1.real * -1,
      -1.real      =>      -1.real * 1,
      0.1.real      =>      1.real * 0.1,
      0.01.real      =>      1.real * 0.01,
      0.01.real      =>      1.real * 0.009,
      0.01.real      =>      1.real * 0.005,
      0.00.real      =>      1.real * 0.0049,
      0.1.real      =>      0.1.real * 1,
      0.01.real      =>      0.01.real * 1,
      0.01.real      =>      0.009.real * 1,
      0.00.real      =>      0.00049.real * 1,
      0.real      =>      0.real * 0.real,
      1.real      =>      1.real * 1.real,
      1.real      =>      0.5.real * 2.real,
      1.real      =>      1 * 1.real,
      -1.real      =>      -1 * 1.real,
      1.real      =>      -1 * -1.real,
      0.01.real      =>      0.01 * 1.real,
    }.each { |esperado, valor| assert_equal esperado, valor }  
  end
  
  # quantia_do
  def testa_quantia_de
    assert_equal 0, @dinheiro.quantia_de(0.real)
    assert_equal 0, @dinheiro.quantia_de(0)
  end

  # to_f
  def testa_to_f
    assert_equal 2.30, 2.30.real.to_f
  end
  
  # quantia_respeita_formato?
  def testa_se_quantia_respeita_formato
    [                         "1211",
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
    "0,01",
    ].each { |quantia| verifica_se_quantia_respeita_formato quantia }
  end
  
  # >, <, == (ordenacao)
  def testa_comparacao_entre_dinheiro
    assert 1.real < 2.reais
    assert 1.real <= 2.reais
    assert 2.real > 1.real
    assert 2.real >= 1.real    
    assert 1.real == 1.real
    assert 1.real >= 1.real
    assert 1.real <= 1.real    
  end
  
  def testa_comparacao_entre_possivel_dinheiro
    assert 1.real < 2.00
    assert 1.real <= 2.00
    assert 2.real > 1.00
    assert 2.real >= 1.00
    assert 1.real == 1.00
    assert 1.real >= 1.00
    assert 1.real <= 1.00
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
    assert_equal "1", Dinheiro.new(1).parte_inteira
    assert_equal "-123112211", Dinheiro.new(-123112211).parte_inteira
  end
  
  def testa_se_arredonda_valores_corretamente
    { 23049 => 230.49, 
      23049 => 230.4949999999,
      23050 => 230.495
    }.each{ |esperado, valor| verifica_se_arredonda_valores_corretamente esperado, valor }
  end

  private
  
  def verifica_se_arredonda_valores_corretamente(esperado, valor)
    assert_equal esperado, Dinheiro.new(valor).quantia, "Deveria retornar #{esperado} para #{valor}"
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
    [ quantia, 
    "R$ #{quantia}", "R$#{quantia}", "R$        #{quantia}",
    "r$ #{quantia}", "r$#{quantia}", "r$        #{quantia}"  ].each do |quantia_str| 
      assert 1.real.quantia_respeita_formato?(quantia_str), "O sistema deveria considerar o quantia '#{quantia_str}' dentro do formato valido."
    end
  end
  
  def verifica_se_cria_dinheiro_para(quantia)
    assert quantia.para_dinheiro.kind_of?(Dinheiro)
  end
  
  def verifica_se_aceita_quantia_valida(esperado, quantia)
    assert_equal esperado, Dinheiro.new(quantia).to_s, "Deveria ter vindo o quantia: #{esperado} quando recebeu #{quantia}"
  end
  
  def verifica_se_coloca_ponto_no_milhar(esperado, inteiro)
    assert_equal esperado, @dinheiro.inteiro_com_milhar(inteiro) 
    assert_equal "-#{esperado}", @dinheiro.inteiro_com_milhar("-#{inteiro}") 
  end
  
  def verifica_se_rejeita_criacao_de_dinheiro_a_partir_de_string_invalida(quantia)
    assert_raise DinheiroInvalidoError, "Deveria ter rejeitado [#{quantia}]" do
      Dinheiro.new quantia
    end
  end
  

  
end
