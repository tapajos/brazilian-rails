module ActiveSupport::CoreExtensions::String::Conversions
  # Cria a data no padrao brasileiro e permanece aceitando no formato tradicional.
  #
  # Exemplo:
  # "27/09/2007".to_date
  def to_date
    if /(\d{1,2})\W(\d{1,2})\W(\d{4})/ =~ self
      ::Date.new($3.to_i, $2.to_i, $1.to_i)
    else
      ::Date.new(*ParseDate.parsedate(self)[0..2])
    end
  end
end

class Date
  
  FERIADOS = []
  
  
  # Retorna a true se a data for um feriado
  #
  # Exemplo:
  #  data = Date.new(2007, 12, 25)
  #  data.feriado? ==> true
  def feriado?
    FERIADOS.include?(Feriado.new("novo_feriado", self.day, self.month)) || self.pascoa? || self.corpus_christi?
  end
  
  # Retorna a pascoa no ano da data atual
  #
  # Exemplo:
  #  data = Date.new(2007, 12, 25)
  #  data.pascoa ==> "2007-4-8"
  def pascoa
    g = self.year % 19
    c = (self.year / 100).floor
    h = (c - ( c / 4 ).floor - ((8 * c) / 25).floor + 19 * g + 15) % 30
    i = h - (h / 28).floor * (1 - (h / 28).floor * (29 / (h + 1)).floor * ((21 - g) / 11).floor)
    j = (self.year + (self.year/ 4).floor + i + 2 - c + (c / 4).floor) % 7
    l = i - j

    month = 3 + ((l + 40) / 44).floor
    day   = l + 28 - (31 * (month / 4 ).floor)
    Date.parse("#{self.year}-#{month}-#{day}")
  end

  #Retorna true se a data atual for a pascoa
  def pascoa?
    pascoa == self
  end

  # Retorna a corpus_christi no ano da data atual
  #
  # Exemplo:
  #  data = Date.new(2007, 12, 25)
  #  data.corpus_christi ==> "2007-06-07"
  def corpus_christi
    Date.parse((pascoa.to_time + 60.days).to_date.to_s)
  end
  
  #Retorna true se a data atual for corpus_christi
  def corpus_christi?
    corpus_christi == self
  end
  
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
