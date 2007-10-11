require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class InflectorTest < Test::Unit::TestCase
  
  #general rule: add "s" to the end of the word
  def test_general_rule
    words = {:casa => "casas",
             :pe => "pes",
             :saci => "sacis",
             :carro => "carros",
             :pneu => "pneus"
            }
    verify_pluralize words
    verify_singularize words
  end

  #if word ends in "r" or "z", add "es"
  def test_when_word_ends_in_r_or_z
    words = {:flor => "flores",
             :luz => "luzes"
            }
    verify_pluralize words
    verify_singularize words
  end
  
  #if word ends in "al", "el", "ol", "ul": trade "l" with "is"
  def test_when_word_ends_in_al_el_ol_ul
      words = {:hospital => "hospitais",
               :telemovel => "telemoveis",
               :farol => "farois",
               :azul => "azuis"
            }
    verify_pluralize words
    verify_singularize words
  end
  
  
  #if word ends in "il" and has tônic accent in last syllable, trade "il" with "is"
  def test_when_word_end_in_il
    words = {:cantil => "cantis"}
    verify_pluralize words
  end


  #if word ends in "m", trade "m" with "ns"
  def test_plurilize_when_word_ends_in_m
    words = {:armazem => "armazens"}
    verify_pluralize words
    verify_singularize words
  end
  
  #if word ends in "s" and has one silable, trade "s" with "es"
  def test_plurilize_when_word_ends_in_s
    words = {:portugues => "portugueses"}
    verify_pluralize words
  end
  
  def test_when_word_ends_in_ao
    words = {:portão => "portões", :portao => 'portoes', :localizacao => 'localizacoes'}
    verify_pluralize words
    verify_singularize words
  end
  
  def test_when_irregular_singular
    words = {:cão => "cães",
             :pão => "pães",
             :mão => "mãos",
             :alemão => "alemães",
             :cao => 'caes',
             :pao => 'paes',
             :mao => 'maos',
             :alemao => 'alemaes'
            }
    verify_singularize words
  end
  
  
  def test_when_uncountable
    words = {:tennis => "tennis",
             :torax => "torax"
            }
    verify_pluralize words
    verify_singularize words
  end
  
  
  private
  
  def verify_pluralize(words)
    words.each { |key,value| assert_equal value, key.to_s.pluralize}    
  end
  
  def verify_singularize(words)
    words.each { |key,value| assert_equal key.to_s, value.singularize}    
  end

end
