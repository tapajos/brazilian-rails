module DinheiroActiveRecord#:nodoc:
  def self.included(base)#:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods#:nodoc:
    def usar_como_dinheiro(*args)#:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Dinheiro', :mapping => [name.to_s, "valor_decimal"], :allow_nil => true

          name = name.to_s
          module_eval <<-ADICIONANDO_METODO
          validate :#{name}_valido?

          def #{name}_valido?
            begin
              @#{name}.to_s.reais
            rescue Exception => e
              self.errors.add('#{name}', e.message)
            end
          end

          def #{name}=(value)
            if value.nil?
              write_attribute('#{name}', nil)
            elsif value.kind_of?(Dinheiro)
              write_attribute('#{name}', value.valor_decimal)
            else
              begin
                write_attribute('#{name}', value.reais.valor_decimal)
              rescue
                @#{name} = value
              end
            end
          end
          ADICIONANDO_METODO
        end
      end
    end
  end
end