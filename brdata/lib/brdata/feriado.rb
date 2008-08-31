# == Configuração dos Feriados
#
# Os feriados são configurados através de arquivos YML que deverão estar na pasta feriados dentro da pasta config da sua aplicação.
#
# Você pode ver exemplos desses YML dentro do diretório samples/feriado.
#
class Feriado
  
  attr_accessor :dia 
  attr_accessor :mes
  attr_accessor :nome
  
  # Construtor um feriado.
  #
  # Exemplo:
  # Feriado.new("nome", "01", "01")
  def initialize(nome, dia, mes)
    valida_dia(dia)
    valida_mes(mes)
    self.nome = nome
    self.dia = dia.to_i 
    self.mes = mes.to_i
    
  end
  
  # Compara dois feriados. Dois feriados são iguais se acontecem na mesma data.
  def ==(outro_feriado)
    self.mes == outro_feriado.mes && self.dia == outro_feriado.dia
  end
  
  private
  
  def valida_dia(dia)
    raise FeriadoDiaInvalidoError unless (1..31).include?(dia.to_i)
  end
  
  def valida_mes(mes)
    raise FeriadoMesInvalidoError unless (1..12).include?(mes.to_i)
  end
  
end

class Date
  
  FERIADOS = []
  FERIADOS_METODOS = []
  
  # Retorna a true se a data for um feriado
  #
  # Exemplo:
  #  data = Date.new(2007, 12, 25)
  #  data.feriado? ==> true
  def feriado?
    return true if FERIADOS.include?(Feriado.new("novo_feriado", self.day, self.month))
    FERIADOS_METODOS.each do |metodo|
      return true if self == send(metodo)
    end
    false
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

  # Retorna a corpus_christi no ano da data atual
  #
  # Exemplo:
  #  data = Date.new(2007, 12, 25)
  #  data.corpus_christi ==> "2007-06-07"
  def corpus_christi
    Date.parse((pascoa.to_time + 60.days).to_date.to_s)
  end
  
end

