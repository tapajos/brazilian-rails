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
            return true if @valor_original.nil?
            begin
              Dinheiro.new(@valor_original) 
            rescue Exception => e
              self.errors.add('#{name}', e.message)
            end
          end

          alias_method :#{name}_original=, :#{name}=
          def #{name}=(value)
            @valor_original = nil
            if value.kind_of?(Dinheiro)
              self.#{name}_original = value 
            else
              begin
                self.#{name}_original = Dinheiro.new(value)
              rescue
                @valor_original = value
                self.#{name}_original = nil
              end
            end
          end
          ADICIONANDO_METODO
        end
      end
    end
  end
end