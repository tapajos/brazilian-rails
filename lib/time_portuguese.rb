class Time
  # Retorna a hora no padrao brasileiro
  #
  # Exemplo:
  #  hora = Time.new
  #  hora.to_s_br ==> "27/09/2007 13:54"
  def to_s_br
    self.strftime("%d/%m/%Y %H:%M")
  end
end