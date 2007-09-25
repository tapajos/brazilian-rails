require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class NumberTest < Test::Unit::TestCase
  def test_unidades
    assert_equal 'zero',   0.to_extenso
    assert_equal 'um',     1.to_extenso
    assert_equal 'dois',   2.to_extenso
    assert_equal 'três',   3.to_extenso
    assert_equal 'quatro', 4.to_extenso
    assert_equal 'cinco',  5.to_extenso
    assert_equal 'seis',   6.to_extenso
    assert_equal 'sete',   7.to_extenso
    assert_equal 'oito',   8.to_extenso
    assert_equal 'nove',   9.to_extenso
  end
  
  def test_dezenas
    assert_equal 'dez',       10.to_extenso
    assert_equal 'onze',      11.to_extenso
    assert_equal 'doze',      12.to_extenso
    assert_equal 'treze',     13.to_extenso
    assert_equal 'quatorze',  14.to_extenso
    assert_equal 'quinze',    15.to_extenso
    assert_equal 'dezesseis', 16.to_extenso
    assert_equal 'dezessete', 17.to_extenso
    assert_equal 'dezoito',   18.to_extenso
    assert_equal 'dezenove',  19.to_extenso
    assert_equal 'vinte',     20.to_extenso
    assert_equal 'trinta',    30.to_extenso
    assert_equal 'quarenta',  40.to_extenso
    assert_equal 'cinquenta', 50.to_extenso
    assert_equal 'sessenta',  60.to_extenso
    assert_equal 'setenta',   70.to_extenso
    assert_equal 'oitenta',   80.to_extenso
    assert_equal 'noventa',   90.to_extenso
  end
  
  def test_dezenas_com_unidades
    assert_equal 'vinte e um',     21.to_extenso
    assert_equal 'trinta e dois',    32.to_extenso
    assert_equal 'quarenta e três',  43.to_extenso
    assert_equal 'cinquenta e quatro', 54.to_extenso
    assert_equal 'sessenta e cinco',  65.to_extenso
    assert_equal 'setenta e seis',   76.to_extenso
    assert_equal 'oitenta e sete',   87.to_extenso
    assert_equal 'noventa e oito',   98.to_extenso
  end
  
  def test_centenas
    assert_equal 'cem', 100.to_extenso
    assert_equal 'duzentos', 200.to_extenso
    assert_equal 'trezentos', 300.to_extenso
    assert_equal 'quatrocentos', 400.to_extenso
    assert_equal 'quinhentos', 500.to_extenso
    assert_equal 'seiscentos', 600.to_extenso
    assert_equal 'setecentos', 700.to_extenso
    assert_equal 'oitocentos', 800.to_extenso
    assert_equal 'novecentos', 900.to_extenso
  end
  
  def test_centenas_com_dezenas_e_unidades    
    assert_equal 'cento e um', 101.to_extenso
    assert_equal 'cento e dez', 110.to_extenso
    assert_equal 'cento e onze', 111.to_extenso
    
    assert_equal 'duzentos e dois', 202.to_extenso
    assert_equal 'duzentos e vinte', 220.to_extenso
    assert_equal 'duzentos e vinte e dois', 222.to_extenso
    
    assert_equal 'trezentos e três', 303.to_extenso
    assert_equal 'trezentos e trinta', 330.to_extenso
    assert_equal 'trezentos e trinta e três', 333.to_extenso
    
    assert_equal 'quatrocentos e quatro', 404.to_extenso
    assert_equal 'quatrocentos e quarenta', 440.to_extenso
    assert_equal 'quatrocentos e quarenta e quatro', 444.to_extenso
    
    assert_equal 'quinhentos e cinco', 505.to_extenso
    assert_equal 'quinhentos e cinquenta', 550.to_extenso
    assert_equal 'quinhentos e cinquenta e cinco', 555.to_extenso
    
    assert_equal 'seiscentos e seis', 606.to_extenso
    assert_equal 'seiscentos e sessenta', 660.to_extenso
    assert_equal 'seiscentos e sessenta e seis', 666.to_extenso
    
    assert_equal 'setecentos e sete', 707.to_extenso
    assert_equal 'setecentos e setenta', 770.to_extenso
    assert_equal 'setecentos e setenta e sete', 777.to_extenso
    
    assert_equal 'oitocentos e oito', 808.to_extenso
    assert_equal 'oitocentos e oitenta', 880.to_extenso
    assert_equal 'oitocentos e oitenta e oito', 888.to_extenso
    
    assert_equal 'novecentos e nove', 909.to_extenso
    assert_equal 'novecentos e noventa', 990.to_extenso
    assert_equal 'novecentos e noventa e nove', 999.to_extenso
  end
  
  def test_mil
    assert_equal 'um mil', 1_000.to_extenso
    assert_equal 'um mil e um', 1_001.to_extenso
    assert_equal 'um mil e dez', 1_010.to_extenso
    assert_equal 'um mil e onze', 1_011.to_extenso
    assert_equal 'um mil e cem', 1_100.to_extenso
    assert_equal 'um mil e cento e um', 1_101.to_extenso
    assert_equal 'um mil e cento e dez', 1_110.to_extenso
    assert_equal 'um mil e cento e onze', 1_111.to_extenso
    assert_equal 'dez mil', 10_000.to_extenso
    assert_equal 'cem mil', 100_000.to_extenso    
    assert_equal 'cento e dez mil', 110_000.to_extenso
  end
  
  def test_milhao
    assert_equal 'um milhão', 1_000_000.to_extenso
    assert_equal 'um milhão e um mil e um', 1_001_001.to_extenso
    assert_equal 'um milhão e dez mil e dez', 1_010_010.to_extenso
    assert_equal 'um milhão e onze mil e onze', 1_011_011.to_extenso
    assert_equal 'um milhão e cem mil e cem', 1_100_100.to_extenso
    assert_equal 'um milhão e cento e um mil e cento e um', 1_101_101.to_extenso
    assert_equal 'um milhão e cento e dez mil e cento e dez', 1_110_110.to_extenso
    assert_equal 'um milhão e cento e onze mil e cento e onze', 1_111_111.to_extenso
    assert_equal 'dez milhões', 10_000_000.to_extenso
    assert_equal 'cem milhões', 100_000_000.to_extenso    
    assert_equal 'cento e dez milhões', 110_000_000.to_extenso
  end
  
  def test_bilhao
    assert_equal 'um bilhão', 1_000_000_000.to_extenso
    assert_equal 'um bilhão e um milhão e um mil e um', 1_001_001_001.to_extenso
    assert_equal 'um bilhão e dez milhões e dez mil e dez', 1_010_010_010.to_extenso
    assert_equal 'um bilhão e onze milhões e onze mil e onze', 1_011_011_011.to_extenso
    assert_equal 'um bilhão e cem milhões e cem mil e cem', 1_100_100_100.to_extenso
    assert_equal 'um bilhão e cento e um milhões e cento e um mil e cento e um', 1_101_101_101.to_extenso
    assert_equal 'um bilhão e cento e dez milhões e cento e dez mil e cento e dez', 1_110_110_110.to_extenso
    assert_equal 'um bilhão e cento e onze milhões e cento e onze mil e cento e onze', 1_111_111_111.to_extenso
    assert_equal 'dez bilhões', 10_000_000_000.to_extenso
    assert_equal 'cem bilhões', 100_000_000_000.to_extenso    
    assert_equal 'cento e dez bilhões', 110_000_000_000.to_extenso
  end
  
  def test_trilhao
    assert_equal 'um trilhão', 1_000_000_000_000.to_extenso
    assert_equal 'um trilhão e um bilhão e um milhão e um mil e um', 1_001_001_001_001.to_extenso
    assert_equal 'um trilhão e dez bilhões e dez milhões e dez mil e dez', 1_010_010_010_010.to_extenso
    assert_equal 'um trilhão e onze bilhões e onze milhões e onze mil e onze', 1_011_011_011_011.to_extenso
    assert_equal 'um trilhão e cem bilhões e cem milhões e cem mil e cem', 1_100_100_100_100.to_extenso
    assert_equal 'um trilhão e cento e um bilhões e cento e um milhões e cento e um mil e cento e um', 1_101_101_101_101.to_extenso
    assert_equal 'um trilhão e cento e dez bilhões e cento e dez milhões e cento e dez mil e cento e dez', 1_110_110_110_110.to_extenso
    assert_equal 'um trilhão e cento e onze bilhões e cento e onze milhões e cento e onze mil e cento e onze', 1_111_111_111_111.to_extenso
    assert_equal 'dez trilhões', 10_000_000_000_000.to_extenso
    assert_equal 'cem trilhões', 100_000_000_000_000.to_extenso    
    assert_equal 'cento e dez trilhões', 110_000_000_000_000.to_extenso
  end
  
  def test_numero_maior_que_trilhao_eh_rejetaido
    begin
      1_000_000_000_000_000.to_extenso
      raise "Deveria lançar RuntimeError com mensagem 'Valor excede o permitido'"
      rescue RuntimeError => e
      assert_equal RuntimeError, e.class
      assert_equal 'Valor excede o permitido: 1000000000000000', e.message
    end
  end
  
  def test_valores_em_real
    assert_equal 'grátis', 0.to_extenso_real
    assert_equal 'um centavo', 0.01.to_extenso_real 
    assert_equal 'dois centavos', 0.02.to_extenso_real 
    assert_equal 'vinte e um centavos', 0.21.to_extenso_real 
    assert_equal 'um real', 1.00.to_extenso_real 
    assert_equal 'um real', 1.to_extenso_real 
    assert_equal 'um real e um centavo', 1.01.to_extenso_real 
    assert_equal 'um real e dois centavos', 1.02.to_extenso_real 
    assert_equal 'um milhão de reais e um centavo', 1_000_000.01.to_extenso_real 
    assert_equal 'dois milhões de reais e um centavo', 2_000_000.01.to_extenso_real 
    assert_equal 'dois milhões e duzentos reais e um centavo', 2_000_200.01.to_extenso_real 
    assert_equal 'um bilhão de reais e um centavo', 1_000_000_000.01.to_extenso_real 
    assert_equal 'um trilhão de reais e um centavo', 1_000_000_000_000.01.to_extenso_real
    assert_equal 'cento e vinte e oito mil e duzentos e quarenta e três reais e vinte e oito centavos', 128_243.28.to_extenso_real
    assert_equal 'oitenta e dois mil e trezentos e oitenta e nove reais e dezenove centavos', 82_389.19.to_extenso_real
    assert_equal 'dois mil e trezentos e quarenta e sete reais e vinte e oito centavos', 2_347.28.to_extenso_real
    assert_equal 'noventa e dois mil e trezentos e setenta e dois reais e oitenta e seis centavos', 92_372.86.to_extenso_real
  end
end
