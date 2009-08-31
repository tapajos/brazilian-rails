module DinheiroUtil

  # Ao incluir o modulo, cria aliases para_dinheiro
  def self.included(base)
    base.class_eval do
      # Alias para para_dinheiro
      alias_method :real, :para_dinheiro

      # Alias para para_dinheiro
      alias_method :reais, :para_dinheiro
    end
  end

  # Transforma numero em dinheiro
  #
  # Exemplo:
  #  1.para_dinheiro.class ==> Dinheiro
  def para_dinheiro
    Dinheiro.new(self)
  end

  # Retorna string formatada com simbolo monetario
  #
  # Exemplo:
  #  1.real_contabil ==> 'R$ 1,00'
  #  -1.real_contabil ==> 'R$ (1,00)'
  def real_contabil
    Dinheiro.new(self).real_contabil
  end
  
  # Retorna string formatada com simbolo monetario
  #
  # Exemplo:
  #  2.reais_contabeis ==> 'R$ 2,00'
  #  -2.reais_contabeis ==> 'R$ 2,00'
  def reais_contabeis
    Dinheiro.new(self).reais_contabeis
  end
  
  # Retorna string formatada com simbolo monetario
  #
  # Exemplo:
  #  1.contabil ==> '1,00'
  #  -1.contabil ==> '(1,00)'
  def contabil
    Dinheiro.new(self).contabil
  end
end

Numeric.send(:include, DinheiroUtil)
String.send(:include, DinheiroUtil)
