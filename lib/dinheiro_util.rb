module DinheiroUtil
  # Transforma numero em dinheiro
  #
  # Exemplo:
  #  1.para_dinheiro.class ==> Dinheiro
  def para_dinheiro
    Dinheiro.new(self)
  end
  
  # Alias para para_dinheiro
  alias_method :reais, :para_dinheiro
  
  # Alias para para_dinheiro
  alias_method :real, :para_dinheiro
  
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

module DinheiroActiveRecord#:nodoc:
  def self.included(base)#:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods#:nodoc:
    def usar_como_dinheiro(*args)#:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Dinheiro', :mapping => [name, "#{name.to_s}_decimal"]
          name = name.to_s
      
          module_eval <<-ADICIONANDO_METODO
        alias_method :#{name}_original=, :#{name}=

        def #{name}= valor
          self.#{name}_original = valor if valor.kind_of?(Dinheiro)
          self.#{name}_original = valor.real unless valor.kind_of?(Dinheiro)
        end
          ADICIONANDO_METODO
        end
      end
    end
  end
end