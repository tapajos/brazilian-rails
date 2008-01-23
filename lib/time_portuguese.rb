class Time
  alias :strftime_nolocale :strftime

  # Retorna a hora no padrao brasileiro
  #
  # Exemplo:
  #  hora = Time.new
  #  hora.to_s_br ==> "27/09/2007 13:54"
  def to_s_br
    self.strftime("%d/%m/%Y %H:%M")
  end
  
  # Formata a hora usando nomes de dias e meses em Portugues
  # Exemplo:
  # hora = Time.new
  # hora.strftime("%B") ==> "Janeiro"
  # http://forum.rubyonbr.org/forums/1/topics/261
  def strftime(format)
    format = format.dup
    format.gsub!(/%a/, Date::ABBR_DAYNAMES[self.wday])
    format.gsub!(/%A/, Date::DAYNAMES[self.wday])
    format.gsub!(/%b/, Date::ABBR_MONTHNAMES[self.mon])
    format.gsub!(/%B/, Date::MONTHNAMES[self.mon])
    self.strftime_nolocale(format)
  end
end