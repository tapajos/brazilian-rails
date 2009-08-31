# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'

class NumberTest < Test::Unit::TestCase
  def test_unidades
    assert_equal 'zero',   0.por_extenso
    assert_equal 'um',     1.por_extenso
    assert_equal 'dois',   2.por_extenso
    assert_equal 'três',   3.por_extenso
    assert_equal 'quatro', 4.por_extenso
    assert_equal 'cinco',  5.por_extenso
    assert_equal 'seis',   6.por_extenso
    assert_equal 'sete',   7.por_extenso
    assert_equal 'oito',   8.por_extenso
    assert_equal 'nove',   9.por_extenso
  end
  
  def test_dezenas
    assert_equal 'dez',       10.por_extenso
    assert_equal 'onze',      11.por_extenso
    assert_equal 'doze',      12.por_extenso
    assert_equal 'treze',     13.por_extenso
    assert_equal 'quatorze',  14.por_extenso
    assert_equal 'quinze',    15.por_extenso
    assert_equal 'dezesseis', 16.por_extenso
    assert_equal 'dezessete', 17.por_extenso
    assert_equal 'dezoito',   18.por_extenso
    assert_equal 'dezenove',  19.por_extenso
    assert_equal 'vinte',     20.por_extenso
    assert_equal 'trinta',    30.por_extenso
    assert_equal 'quarenta',  40.por_extenso
    assert_equal 'cinquenta', 50.por_extenso
    assert_equal 'sessenta',  60.por_extenso
    assert_equal 'setenta',   70.por_extenso
    assert_equal 'oitenta',   80.por_extenso
    assert_equal 'noventa',   90.por_extenso
  end
  
  def test_dezenas_com_unidades
    assert_equal 'vinte e um',     21.por_extenso
    assert_equal 'trinta e dois',    32.por_extenso
    assert_equal 'quarenta e três',  43.por_extenso
    assert_equal 'cinquenta e quatro', 54.por_extenso
    assert_equal 'sessenta e cinco',  65.por_extenso
    assert_equal 'setenta e seis',   76.por_extenso
    assert_equal 'oitenta e sete',   87.por_extenso
    assert_equal 'noventa e oito',   98.por_extenso
  end
  
  def test_centenas
    assert_equal 'cem', 100.por_extenso
    assert_equal 'duzentos', 200.por_extenso
    assert_equal 'trezentos', 300.por_extenso
    assert_equal 'quatrocentos', 400.por_extenso
    assert_equal 'quinhentos', 500.por_extenso
    assert_equal 'seiscentos', 600.por_extenso
    assert_equal 'setecentos', 700.por_extenso
    assert_equal 'oitocentos', 800.por_extenso
    assert_equal 'novecentos', 900.por_extenso
  end
  
  def test_centenas_com_dezenas_e_unidades    
    assert_equal 'cento e um', 101.por_extenso
    assert_equal 'cento e dez', 110.por_extenso
    assert_equal 'cento e onze', 111.por_extenso
    
    assert_equal 'duzentos e dois', 202.por_extenso
    assert_equal 'duzentos e vinte', 220.por_extenso
    assert_equal 'duzentos e vinte e dois', 222.por_extenso
    
    assert_equal 'trezentos e três', 303.por_extenso
    assert_equal 'trezentos e trinta', 330.por_extenso
    assert_equal 'trezentos e trinta e três', 333.por_extenso
    
    assert_equal 'quatrocentos e quatro', 404.por_extenso
    assert_equal 'quatrocentos e quarenta', 440.por_extenso
    assert_equal 'quatrocentos e quarenta e quatro', 444.por_extenso
    
    assert_equal 'quinhentos e cinco', 505.por_extenso
    assert_equal 'quinhentos e cinquenta', 550.por_extenso
    assert_equal 'quinhentos e cinquenta e cinco', 555.por_extenso
    
    assert_equal 'seiscentos e seis', 606.por_extenso
    assert_equal 'seiscentos e sessenta', 660.por_extenso
    assert_equal 'seiscentos e sessenta e seis', 666.por_extenso
    
    assert_equal 'setecentos e sete', 707.por_extenso
    assert_equal 'setecentos e setenta', 770.por_extenso
    assert_equal 'setecentos e setenta e sete', 777.por_extenso
    
    assert_equal 'oitocentos e oito', 808.por_extenso
    assert_equal 'oitocentos e oitenta', 880.por_extenso
    assert_equal 'oitocentos e oitenta e oito', 888.por_extenso
    
    assert_equal 'novecentos e nove', 909.por_extenso
    assert_equal 'novecentos e noventa', 990.por_extenso
    assert_equal 'novecentos e noventa e nove', 999.por_extenso
  end
  
  def test_mil
    assert_equal 'um mil', 1_000.por_extenso
    assert_equal 'um mil e um', 1_001.por_extenso
    assert_equal 'um mil e dez', 1_010.por_extenso
    assert_equal 'um mil e onze', 1_011.por_extenso
    assert_equal 'um mil e cem', 1_100.por_extenso
    assert_equal 'um mil e cento e um', 1_101.por_extenso
    assert_equal 'um mil e cento e dez', 1_110.por_extenso
    assert_equal 'um mil e cento e onze', 1_111.por_extenso
    assert_equal 'dez mil', 10_000.por_extenso
    assert_equal 'cem mil', 100_000.por_extenso    
    assert_equal 'cento e dez mil', 110_000.por_extenso
  end
  
  def test_milhao
    assert_equal 'um milhão', 1_000_000.por_extenso
    assert_equal 'um milhão e um mil e um', 1_001_001.por_extenso
    assert_equal 'um milhão e dez mil e dez', 1_010_010.por_extenso
    assert_equal 'um milhão e onze mil e onze', 1_011_011.por_extenso
    assert_equal 'um milhão e cem mil e cem', 1_100_100.por_extenso
    assert_equal 'um milhão e cento e um mil e cento e um', 1_101_101.por_extenso
    assert_equal 'um milhão e cento e dez mil e cento e dez', 1_110_110.por_extenso
    assert_equal 'um milhão e cento e onze mil e cento e onze', 1_111_111.por_extenso
    assert_equal 'dez milhões', 10_000_000.por_extenso
    assert_equal 'cem milhões', 100_000_000.por_extenso    
    assert_equal 'cento e dez milhões', 110_000_000.por_extenso
  end
  
  def test_bilhao
    assert_equal 'um bilhão', 1_000_000_000.por_extenso
    assert_equal 'um bilhão e um milhão e um mil e um', 1_001_001_001.por_extenso
    assert_equal 'um bilhão e dez milhões e dez mil e dez', 1_010_010_010.por_extenso
    assert_equal 'um bilhão e onze milhões e onze mil e onze', 1_011_011_011.por_extenso
    assert_equal 'um bilhão e cem milhões e cem mil e cem', 1_100_100_100.por_extenso
    assert_equal 'um bilhão e cento e um milhões e cento e um mil e cento e um', 1_101_101_101.por_extenso
    assert_equal 'um bilhão e cento e dez milhões e cento e dez mil e cento e dez', 1_110_110_110.por_extenso
    assert_equal 'um bilhão e cento e onze milhões e cento e onze mil e cento e onze', 1_111_111_111.por_extenso
    assert_equal 'dez bilhões', 10_000_000_000.por_extenso
    assert_equal 'cem bilhões', 100_000_000_000.por_extenso    
    assert_equal 'cento e dez bilhões', 110_000_000_000.por_extenso
  end
  
  def test_trilhao
    assert_equal 'um trilhão', 1_000_000_000_000.por_extenso
    assert_equal 'um trilhão e um bilhão e um milhão e um mil e um', 1_001_001_001_001.por_extenso
    assert_equal 'um trilhão e dez bilhões e dez milhões e dez mil e dez', 1_010_010_010_010.por_extenso
    assert_equal 'um trilhão e onze bilhões e onze milhões e onze mil e onze', 1_011_011_011_011.por_extenso
    assert_equal 'um trilhão e cem bilhões e cem milhões e cem mil e cem', 1_100_100_100_100.por_extenso
    assert_equal 'um trilhão e cento e um bilhões e cento e um milhões e cento e um mil e cento e um', 1_101_101_101_101.por_extenso
    assert_equal 'um trilhão e cento e dez bilhões e cento e dez milhões e cento e dez mil e cento e dez', 1_110_110_110_110.por_extenso
    assert_equal 'um trilhão e cento e onze bilhões e cento e onze milhões e cento e onze mil e cento e onze', 1_111_111_111_111.por_extenso
    assert_equal 'dez trilhões', 10_000_000_000_000.por_extenso
    assert_equal 'cem trilhões', 100_000_000_000_000.por_extenso    
    assert_equal 'cento e dez trilhões', 110_000_000_000_000.por_extenso
  end
  
  def test_numero_maior_que_trilhao_eh_rejetaido
    begin
      1_000_000_000_000_000.por_extenso
      raise "Deveria lançar RuntimeError com mensagem 'Valor excede o permitido'"
      rescue RuntimeError => e
      assert_equal RuntimeError, e.class
      assert_equal 'Valor excede o permitido: 1000000000000000', e.message
    end
  end
  
  def test_valores_em_real
    assert_equal 'grátis', 0.por_extenso_em_reais
    assert_equal 'um centavo', 0.01.por_extenso_em_reais 
    assert_equal 'dois centavos', 0.02.por_extenso_em_reais 
    assert_equal 'vinte e um centavos', 0.21.por_extenso_em_reais 
    assert_equal 'um real', 1.00.por_extenso_em_reais 
    assert_equal 'um real', 1.por_extenso_em_reais 
    assert_equal 'um real e um centavo', 1.01.por_extenso_em_reais 
    assert_equal 'um real e dois centavos', 1.02.por_extenso_em_reais 
    assert_equal 'um milhão de reais e um centavo', 1_000_000.01.por_extenso_em_reais 
    assert_equal 'dois milhões de reais e um centavo', 2_000_000.01.por_extenso_em_reais 
    assert_equal 'dois milhões e duzentos reais e um centavo', 2_000_200.01.por_extenso_em_reais 
    assert_equal 'um bilhão de reais e um centavo', 1_000_000_000.01.por_extenso_em_reais 
    assert_equal 'um trilhão de reais e um centavo', 1_000_000_000_000.01.por_extenso_em_reais
    assert_equal 'cento e vinte e oito mil e duzentos e quarenta e três reais e vinte e oito centavos', 128_243.28.por_extenso_em_reais
    assert_equal 'oitenta e dois mil e trezentos e oitenta e nove reais e dezenove centavos', 82_389.19.por_extenso_em_reais
    assert_equal 'dois mil e trezentos e quarenta e sete reais e vinte e oito centavos', 2_347.28.por_extenso_em_reais
    assert_equal 'noventa e dois mil e trezentos e setenta e dois reais e oitenta e seis centavos', 92_372.86.por_extenso_em_reais
  end

  def test_unidades_negativas
    assert_equal 'zero',   -0.por_extenso #Aha, tentou me pegar :)
    assert_equal 'menos um',     -1.por_extenso
    assert_equal 'menos dois',   -2.por_extenso
    assert_equal 'menos três',   -3.por_extenso
    assert_equal 'menos quatro', -4.por_extenso
    assert_equal 'menos cinco',  -5.por_extenso
    assert_equal 'menos seis',   -6.por_extenso
    assert_equal 'menos sete',   -7.por_extenso
    assert_equal 'menos oito',   -8.por_extenso
    assert_equal 'menos nove',   -9.por_extenso
  end

  def test_dezenas_negativas
    assert_equal 'menos dez',       -10.por_extenso
    assert_equal 'menos onze',      -11.por_extenso
    assert_equal 'menos doze',      -12.por_extenso
    assert_equal 'menos treze',     -13.por_extenso
    assert_equal 'menos quatorze',  -14.por_extenso
    assert_equal 'menos quinze',    -15.por_extenso
    assert_equal 'menos dezesseis', -16.por_extenso
    assert_equal 'menos dezessete', -17.por_extenso
    assert_equal 'menos dezoito',   -18.por_extenso
    assert_equal 'menos dezenove',  -19.por_extenso
    assert_equal 'menos vinte',     -20.por_extenso
    assert_equal 'menos trinta',    -30.por_extenso
    assert_equal 'menos quarenta',  -40.por_extenso
    assert_equal 'menos cinquenta', -50.por_extenso
    assert_equal 'menos sessenta',  -60.por_extenso
    assert_equal 'menos setenta',   -70.por_extenso
    assert_equal 'menos oitenta',   -80.por_extenso
    assert_equal 'menos noventa',   -90.por_extenso
  end

  def test_dezenas_com_unidades_negativas
    assert_equal 'menos vinte e um',     -21.por_extenso
    assert_equal 'menos trinta e dois',    -32.por_extenso
    assert_equal 'menos quarenta e três',  -43.por_extenso
    assert_equal 'menos cinquenta e quatro', -54.por_extenso
    assert_equal 'menos sessenta e cinco',  -65.por_extenso
    assert_equal 'menos setenta e seis',   -76.por_extenso
    assert_equal 'menos oitenta e sete',   -87.por_extenso
    assert_equal 'menos noventa e oito',   -98.por_extenso
  end

  def test_centenas_negativas
    assert_equal 'menos cem', -100.por_extenso
    assert_equal 'menos duzentos', -200.por_extenso
    assert_equal 'menos trezentos', -300.por_extenso
    assert_equal 'menos quatrocentos', -400.por_extenso
    assert_equal 'menos quinhentos', -500.por_extenso
    assert_equal 'menos seiscentos', -600.por_extenso
    assert_equal 'menos setecentos', -700.por_extenso
    assert_equal 'menos oitocentos', -800.por_extenso
    assert_equal 'menos novecentos', -900.por_extenso
  end

  def test_centenas_com_dezenas_e_unidades_negativas
    assert_equal 'menos cento e um', -101.por_extenso
    assert_equal 'menos cento e dez', -110.por_extenso
    assert_equal 'menos cento e onze', -111.por_extenso

    assert_equal 'menos duzentos e dois', -202.por_extenso
    assert_equal 'menos duzentos e vinte', -220.por_extenso
    assert_equal 'menos duzentos e vinte e dois', -222.por_extenso

    assert_equal 'menos trezentos e três', -303.por_extenso
    assert_equal 'menos trezentos e trinta', -330.por_extenso
    assert_equal 'menos trezentos e trinta e três', -333.por_extenso

    assert_equal 'menos quatrocentos e quatro', -404.por_extenso
    assert_equal 'menos quatrocentos e quarenta', -440.por_extenso
    assert_equal 'menos quatrocentos e quarenta e quatro', -444.por_extenso

    assert_equal 'menos quinhentos e cinco', -505.por_extenso
    assert_equal 'menos quinhentos e cinquenta', -550.por_extenso
    assert_equal 'menos quinhentos e cinquenta e cinco', -555.por_extenso

    assert_equal 'menos seiscentos e seis', -606.por_extenso
    assert_equal 'menos seiscentos e sessenta', -660.por_extenso
    assert_equal 'menos seiscentos e sessenta e seis', -666.por_extenso

    assert_equal 'menos setecentos e sete', -707.por_extenso
    assert_equal 'menos setecentos e setenta', -770.por_extenso
    assert_equal 'menos setecentos e setenta e sete', -777.por_extenso

    assert_equal 'menos oitocentos e oito', -808.por_extenso
    assert_equal 'menos oitocentos e oitenta', -880.por_extenso
    assert_equal 'menos oitocentos e oitenta e oito', -888.por_extenso

    assert_equal 'menos novecentos e nove', -909.por_extenso
    assert_equal 'menos novecentos e noventa', -990.por_extenso
    assert_equal 'menos novecentos e noventa e nove', -999.por_extenso
  end

  def test_mil_negativo
    assert_equal 'menos um mil', -1_000.por_extenso
    assert_equal 'menos um mil e um', -1_001.por_extenso
    assert_equal 'menos um mil e dez', -1_010.por_extenso
    assert_equal 'menos um mil e onze', -1_011.por_extenso
    assert_equal 'menos um mil e cem', -1_100.por_extenso
    assert_equal 'menos um mil e cento e um', -1_101.por_extenso
    assert_equal 'menos um mil e cento e dez', -1_110.por_extenso
    assert_equal 'menos um mil e cento e onze', -1_111.por_extenso
    assert_equal 'menos dez mil', -10_000.por_extenso
    assert_equal 'menos cem mil', -100_000.por_extenso
    assert_equal 'menos cento e dez mil', -110_000.por_extenso
  end

  def test_milhao_negativo
    assert_equal 'menos um milhão', -1_000_000.por_extenso
    assert_equal 'menos um milhão e um mil e um', -1_001_001.por_extenso
    assert_equal 'menos um milhão e dez mil e dez', -1_010_010.por_extenso
    assert_equal 'menos um milhão e onze mil e onze', -1_011_011.por_extenso
    assert_equal 'menos um milhão e cem mil e cem', -1_100_100.por_extenso
    assert_equal 'menos um milhão e cento e um mil e cento e um', -1_101_101.por_extenso
    assert_equal 'menos um milhão e cento e dez mil e cento e dez', -1_110_110.por_extenso
    assert_equal 'menos um milhão e cento e onze mil e cento e onze', -1_111_111.por_extenso
    assert_equal 'menos dez milhões', -10_000_000.por_extenso
    assert_equal 'menos cem milhões', -100_000_000.por_extenso
    assert_equal 'menos cento e dez milhões', -110_000_000.por_extenso
  end

  def test_bilhao_negativo
    assert_equal 'menos um bilhão', -1_000_000_000.por_extenso
    assert_equal 'menos um bilhão e um milhão e um mil e um', -1_001_001_001.por_extenso
    assert_equal 'menos um bilhão e dez milhões e dez mil e dez', -1_010_010_010.por_extenso
    assert_equal 'menos um bilhão e onze milhões e onze mil e onze', -1_011_011_011.por_extenso
    assert_equal 'menos um bilhão e cem milhões e cem mil e cem', -1_100_100_100.por_extenso
    assert_equal 'menos um bilhão e cento e um milhões e cento e um mil e cento e um', -1_101_101_101.por_extenso
    assert_equal 'menos um bilhão e cento e dez milhões e cento e dez mil e cento e dez', -1_110_110_110.por_extenso
    assert_equal 'menos um bilhão e cento e onze milhões e cento e onze mil e cento e onze', -1_111_111_111.por_extenso
    assert_equal 'menos dez bilhões', -10_000_000_000.por_extenso
    assert_equal 'menos cem bilhões', -100_000_000_000.por_extenso
    assert_equal 'menos cento e dez bilhões', -110_000_000_000.por_extenso
  end

  def test_trilhao_negativo
    assert_equal 'menos um trilhão', -1_000_000_000_000.por_extenso
    assert_equal 'menos um trilhão e um bilhão e um milhão e um mil e um', -1_001_001_001_001.por_extenso
    assert_equal 'menos um trilhão e dez bilhões e dez milhões e dez mil e dez', -1_010_010_010_010.por_extenso
    assert_equal 'menos um trilhão e onze bilhões e onze milhões e onze mil e onze', -1_011_011_011_011.por_extenso
    assert_equal 'menos um trilhão e cem bilhões e cem milhões e cem mil e cem', -1_100_100_100_100.por_extenso
    assert_equal 'menos um trilhão e cento e um bilhões e cento e um milhões e cento e um mil e cento e um', -1_101_101_101_101.por_extenso
    assert_equal 'menos um trilhão e cento e dez bilhões e cento e dez milhões e cento e dez mil e cento e dez', -1_110_110_110_110.por_extenso
    assert_equal 'menos um trilhão e cento e onze bilhões e cento e onze milhões e cento e onze mil e cento e onze', -1_111_111_111_111.por_extenso
    assert_equal 'menos dez trilhões', -10_000_000_000_000.por_extenso
    assert_equal 'menos cem trilhões', -100_000_000_000_000.por_extenso
    assert_equal 'menos cento e dez trilhões', -110_000_000_000_000.por_extenso
  end

  def test_valores_em_real_negativos
    assert_equal 'grátis', -0.por_extenso_em_reais #grátis é grátis
    assert_equal 'um centavo negativo', -0.01.por_extenso_em_reais
    assert_equal 'dois centavos negativos', -0.02.por_extenso_em_reais
    assert_equal 'vinte e um centavos negativos', -0.21.por_extenso_em_reais
    assert_equal 'um real negativo', -1.00.por_extenso_em_reais
    assert_equal 'um real negativo', -1.por_extenso_em_reais
    assert_equal 'um real e um centavo negativos', -1.01.por_extenso_em_reais
    assert_equal 'um real e dois centavos negativos', -1.02.por_extenso_em_reais
    assert_equal 'um milhão de reais e um centavo negativos', -1_000_000.01.por_extenso_em_reais
    assert_equal 'dois milhões de reais e um centavo negativos', -2_000_000.01.por_extenso_em_reais
    assert_equal 'dois milhões e duzentos reais e um centavo negativos', -2_000_200.01.por_extenso_em_reais
    assert_equal 'um bilhão de reais e um centavo negativos', -1_000_000_000.01.por_extenso_em_reais
    assert_equal 'um trilhão de reais e um centavo negativos', -1_000_000_000_000.01.por_extenso_em_reais
    assert_equal 'cento e vinte e oito mil e duzentos e quarenta e três reais e vinte e oito centavos negativos', -128_243.28.por_extenso_em_reais
    assert_equal 'oitenta e dois mil e trezentos e oitenta e nove reais e dezenove centavos negativos', -82_389.19.por_extenso_em_reais
    assert_equal 'dois mil e trezentos e quarenta e sete reais e vinte e oito centavos negativos', -2_347.28.por_extenso_em_reais
    assert_equal 'noventa e dois mil e trezentos e setenta e dois reais e oitenta e seis centavos negativos', -92_372.86.por_extenso_em_reais
  end

end
