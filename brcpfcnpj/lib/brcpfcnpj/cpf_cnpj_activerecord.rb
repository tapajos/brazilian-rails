module CpfCnpjActiveRecord #:nodoc:
  def self.included(base) #:nodoc:
    base.extend ClassMethods
  end
  module ClassMethods #:nodoc:
    def usar_como_cpf(*args) #:nodoc:
      init(args, 'Cpf')
    end
    
    def usar_como_cnpj(*args) #:nodoc:
      init(args, 'Cnpj')
    end

    def init(args, klass)
      unless args.size.zero?
        args.each do |name|
          add_composed_class(name, klass)
          module_eval create_code(name.to_s, klass)
        end
      end      
    end

    def add_composed_class(name, klass)
      options = {:class_name => klass, :mapping => [name.to_s, "numero"], :allow_nil => true}
      constructor = Proc.new { |numero| eval(klass).new(numero) }
      converter   = Proc.new { |value| eval(klass).new(value) }
      begin 
        composed_of name, options.merge( { :constructor => constructor, :converter => converter } )
      rescue Exception 
        composed_of name, options { eval(klass).new(name[:numero]) }
      end
    end

    def create_code(name, klass)
      str = <<-CODE
        validate :#{name}_valido?
        def #{name}_valido?
          value = read_attribute('#{name}')
          if !value.nil? && value.strip != '' && !#{name}.nil? && !#{name}.valido?
            self.errors.add('#{name}', 'numero invalido')
          end
        end
        def #{name}=(value)
          if value.blank?            
            write_attribute('#{name}', nil)
          elsif value.kind_of?(#{eval(klass)}) 
            write_attribute('#{name}', value.numero)
          else
            begin               
              c = #{eval(klass)}.new(value)
              c.valido? ? write_attribute('#{name}', c.numero) : write_attribute('#{name}', value) 
            rescue               
              @#{name} = value
            end
          end
        end
      CODE
    end
  end
end
