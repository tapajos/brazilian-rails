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
