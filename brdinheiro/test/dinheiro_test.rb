# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class DinheiroTest < ActiveSupport::TestCase

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

  test "Se criar dinheiro a partir de quantias validas" do
    QUANTIA_VALIDA.each do |esperado, quantia| 
      assert_equal esperado, Dinheiro.new(quantia).to_s, "Deveria ter vindo o quantia: #{esperado} quando recebeu #{quantia}"
    end
  end
  
  # coloca_ponto_no_milhar
  test "Coloca ponto no milhar" do
    PONTO_NO_MILHAR.each do |esperado, quantia| 
      { esperado       =>     quantia,
        "-#{esperado}" => "-#{quantia}" }.each do |esperado, quantia| 
          assert_equal esperado, @dinheiro.inteiro_com_milhar(quantia) 
      end
    end
  end
  
  test "to_s" do
    assert_equal "1,00", Dinheiro.new(1).to_s
    assert_equal "1.000,00", Dinheiro.new(1000).to_s
  end
  
  # real
  test "Real deve ser dinheiro" do
    assert_kind_of(Dinheiro, 1.real)
  end
  
  test "Real é dinheiro" do
    assert_kind_of(Dinheiro, Dinheiro.new(1).real)
  end
  
  test "Real contábil" do
    REAL_CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).real_contabil }
  end  
  
  test "Reais contabeis" do
    REAL_CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).reais_contabeis }
  end  
  
  # reais
  test "reais" do
    assert_equal Dinheiro.new("2,00"), Dinheiro.new(2).reais
  end
  
  test "contabil" do
    CONTABIL.each { |esperado, quantia| assert_equal esperado, Dinheiro.new(quantia).contabil }
  end 

  # real_formatado
  test "real_formatado" do
    assert_equal "R$ 2,00", Dinheiro.new(2).real_formatado
  end
  
  # ==
  test "Igualdade" do
    assert_equal Dinheiro.new(1), Dinheiro.new(1)
  end
  
  test "Igualdade quando passa possivel dinheiro" do
    assert_equal Dinheiro.new(1), 1.0
  end
  
  test "Igualdade quando passa algo que não seja dinheiro" do
    assert_equal false, Dinheiro.new(1) == 'salario'
  end
  
  # / (divisao)
  test "divisão" do
    DIVISAO.each { |parcelas, divisao| assert_equal parcelas, divisao }
  end
  
  test "Divisão por zero" do
    assert_raise(ZeroDivisionError) { 1.real / 0 }
  end
  
  test "Divisão por não escalar" do
    assert_raise(DivisaPorNaoEscalarError) { 10.reais / 2.reais }
  end

  # parcelar
  test "Parcelar" do
    PARCELAS.each { |parcelas, divisao| assert_equal parcelas, divisao }
  end
  
  test "Parcelar por zero" do
    assert_raise(ZeroDivisionError) { 1.real.parcelar 0 }
  end
  
  test "parcelar por algo que não seja um escalar" do
    assert_raise(DivisaPorNaoEscalarError) { 10.reais.parcelar(2.reais) }
  end
  
  # initialize
  test "Se cria dinheiro a partir de float" do
    verifica_se_cria_dinheiro_para 1.0
  end 
  
  test "Se cria dinheiro a partir de fixnum" do
    verifica_se_cria_dinheiro_para 1
  end 
  
  test "Se cria dinheiro a partir de bigdecimal" do
    verifica_se_cria_dinheiro_para BigDecimal.new("1")
  end 

  test "Se cria dinheiro a partir de string" do
    verifica_se_cria_dinheiro_para "1"
  end 
  
  test "Se rejeita criação de dinheiro a partir de astring inválida" do
    QUANTIA_COM_FORMATO_INVALIDO.each do |quantia| 
      assert_raise DinheiroInvalidoError, "Deveria ter rejeitado [#{quantia}]" do
        Dinheiro.new quantia
      end
    end
  end
  
  # + (soma)
  test "soma" do
    SOMA.each{ |esperado, soma| assert_equal esperado, soma }
  end  
  
  # - (subtracao)
  test "subtração" do
    SUBTRACAO.each { |esperado, subtracao| assert_equal esperado, subtracao }
  end
  
  # * (multiplicacao)
  test "multiplicação" do
    MULTIPLICACAO.each { |esperado, multiplicacao| assert_equal esperado, multiplicacao }  
  end
  
  # quantia_de
  test "quantia_de" do
    assert_equal 0, @dinheiro.quantia_de(0.real)
    assert_equal 0, @dinheiro.quantia_de(0)
  end

  # to_f
  test "to_f" do
    assert_equal 2.30, 2.30.real.to_f
    assert_equal 1000, 1000.real.to_f
  end
  
  # quantia_respeita_formato?
  test "quanti respeita formato?" do
    QUANTIA_COM_FORMATO_VALIDO.each { |quantia| verifica_se_quantia_respeita_formato quantia }
  end
  
  # >, <, == (ordenacao)
  test "comparação entre dinheiro" do
    COMPARACAO.each { |comparacao| assert comparacao }
  end
  
  test "comparação entre possível dinheiro" do
    COMPARACAO_COM_ESCALAR.each { |comparacao_com_escalar| assert comparacao_com_escalar }
  end
  
  # decimal
  test "decimal quando todas as casas estão preenchidas" do
    verifica_decimal("12")
  end
  
  test "decimla quando apenas uma das casas esta preenchida" do
    verifica_decimal("10", "1")
  end
  
  test "decimal quando nenhuma das casas esta preenchida" do
    verifica_decimal("00", "")
  end
  
  test "Se transforma em string que representa a quantia quando tem 3 dígitos" do
    verifica_se_transforma_em_string_corretamente "1.23", 123
  end

  test "Se transforma em string que representa a quantia quando tem 2 dígitos" do
    verifica_se_transforma_em_string_corretamente "0.12", 12
  end

  test "Se transforma em string que representa a quantia quando tem 1 dígito" do
    verifica_se_transforma_em_string_corretamente "0.03", 3
  end

  test "Se transforma em string para valores especiais" do
    verifica_se_transforma_em_string_corretamente "-123112211.00", -12311221100          
  end

  # parte_inteira
  test "parte_inteira" do
    PARTE_INTEIRA.each { |quantia| assert_equal "#{quantia}", Dinheiro.new(quantia).parte_inteira }
  end
  
  test "Se arredonda valores corretamente" do
    ARREDONDAMENTO.each do |esperado, quantia| 
      assert_equal esperado, Dinheiro.new(quantia).quantia, "Deveria retornar #{esperado} para #{quantia}"
    end
  end
  
  test "Se valor decimal cria o big decimal corretamente" do
    assert_equal BigDecimal.new("1234.56"), Dinheiro.new("1234,56").valor_decimal
  end

  test "Soma de dinheiro com big decimal" do
    assert_equal Dinheiro.new(200), BigDecimal.new("100").reais + "100".reais
  end
  
  test "Zero quando é zero" do
    assert Dinheiro.new(0).zero?
  end
  
  test "Zero quando não é zero" do
    assert !Dinheiro.new(1).zero?
  end
  
end
