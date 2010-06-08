module ActiveSupport::CoreExtensions::String::Conversions
  # Cria a data com horário no padrao brasileiro e permanece aceitando no formato tradicional.
  #
  # Exemplo:
  # "27/09/2007 01:23".to_date
  
  def to_time
    if /(\d{1,2})\W(\d{1,2})\W(\d{4})(\s((\d{1,2}):(\d{2})))?/ =~ self
      ::Time.mktime($3.to_i, $2.to_i, $1.to_i, $6.to_i, $7.to_i)
    else
      ::Time.parse self
    end
  end
end


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