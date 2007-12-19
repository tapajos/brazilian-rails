module DinheiroActiveRecord#:nodoc:
  def self.included(base)#:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods#:nodoc:
    def usar_como_dinheiro(*args)#:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Dinheiro', :mapping => [name, "valor_decimal"], :allow_nil => false
          name = name.to_s
          module_eval <<-ADICIONANDO_METODO
          
        def #{name}=(value)
          if value.kind_of?(Dinheiro)
            write_attribute(:#{name},value.valor_decimal)
          else
            begin
              value = value.real
              write_attribute(:#{name},value.valor_decimal)
            rescue
              self.valid?
              self.errors.add(:#{name}, $!)
            end
          end
          
        end
          ADICIONANDO_METODO
        end
      end
    end
  end
end
