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
    raise FeriadoDiaInvalidoError if dia.to_i > 31 || dia.to_i == 0
  end
  
  def valida_mes(mes)
    raise FeriadoMesInvalidoError if mes.to_i > 12 || mes.to_i == 0
  end
  
end
