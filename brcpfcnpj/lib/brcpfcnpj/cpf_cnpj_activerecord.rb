module CpfCnpjActiveRecord #:nodoc:
  def self.included(base) #:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods #:nodoc:
    def usar_como_cpf(*args) #:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Cpf', :mapping => [name.to_s, "numero"], :allow_nil => true,
            :constructor => Proc.new { |numero| Cpf.new(numero) }
          name = name.to_s
          module_eval <<-ADICIONANDO_METODOS_PARA_CPF
          validate :#{name}_valido?

          def #{name}_valido?
            value = read_attribute('#{name}')
            if !value.nil? && value.strip != '' && !#{name}.nil? && !#{name}.valido?
              self.errors.add('#{name}', 'numero invalido')
            end
          end  
          
          def #{name}=(value)
            if value.nil?            
              write_attribute('#{name}', nil)
            elsif value.kind_of?(Cpf) 
              write_attribute('#{name}', value.numero)
            else
              begin               
                write_attribute('#{name}', value)
              rescue               
                @#{name} = value
              end
            end
          end
          ADICIONANDO_METODOS_PARA_CPF
        end
      end
    end
    
    def usar_como_cnpj(*args) #:nodoc:
      unless args.size.zero?
        args.each do |name|
          composed_of name, :class_name => 'Cnpj', :mapping => [name.to_s, "numero"], :allow_nil => true,
            :constructor => Proc.new { |numero| Cnpj.new(numero) }
          name = name.to_s
          module_eval <<-ADICIONANDO_METODOS_PARA_CNPJ
          validate :#{name}_valido?

          def #{name}_valido?
            value = read_attribute('#{name}')
            if !value.nil? && value.strip != '' && !#{name}.nil? && !#{name}.valido?
              self.errors.add('#{name}', 'numero invalido')
            end
          end

          def #{name}=(value)
            if value.nil?
              write_attribute('#{name}', nil)
            elsif value.kind_of?(Cnpj)
              write_attribute('#{name}', value.numero)
            else
              begin
                write_attribute('#{name}', value)
              rescue
                @#{name} = value
              end
            end
          end
          ADICIONANDO_METODOS_PARA_CNPJ
        end
      end      
    end
  end
end
