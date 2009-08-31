module ActiveSupport::CoreExtensions::String::Conversions
  # Cria a data no padrao brasileiro e permanece aceitando no formato tradicional.
  #
  # Exemplo:
  # "27/09/2007".to_date
  def to_date
    if /(\d{1,2})\W(\d{1,2})\W(\d{4})/ =~ self
      ::Date.new($3.to_i, $2.to_i, $1.to_i)
    else
      ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday))
    end
  end
end

class Date
  
  # Retorna a data no padrao brasileiro
  #
  # Exemplo:
  #  data = Date.new(2007, 9, 27)
  #  data.to_s_br ==> "27/09/2007"
  def to_s_br
    strftime("%d/%m/%Y")
  end
  
  # Valida se uma string eh uma data valida
  #
  # Exemplo:
  #  Date.valid?('01/01/2007') ==> true
  #  Date.valid?('32/01/2007') ==> false
  def self.valid?(date)
    begin
      date = date.to_date
      Date.valid_civil?(date.year, date.month, date.day)        
    rescue
      return false
    end
    true
  end
  
end

class NilClass
  def to_s_br
    ""
  end
end
