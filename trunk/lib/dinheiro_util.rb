module DinheiroUtil

  def para_dinheiro
    Dinheiro.new(self)
  end

  def reais
    Dinheiro.new(self)
  end

  def real
    Dinheiro.new(self)
  end
  
  def real_contabil
    Dinheiro.new(self).real_contabil
  end
  
  def reais_contabeis
    Dinheiro.new(self).reais_contabeis
  end
  
  def contabil
    Dinheiro.new(self).contabil
  end
  
end