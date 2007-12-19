module DinheiroActiveRecord#:nodoc:
  def self.included(base)#:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods#:nodoc:
    def usar_como_dinheiro(*args)#:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Dinheiro', :mapping => [name, "#{name.to_s}_decimal"], :allow_nil => true
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