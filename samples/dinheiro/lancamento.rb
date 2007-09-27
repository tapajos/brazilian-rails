class Lancamento < ActiveRecord::Base
  composed_of :valor, 
              :class_name => Dinheiro, 
              :mapping => [[:valor, :valor_decimal]];
end
