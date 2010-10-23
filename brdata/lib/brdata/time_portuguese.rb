class String
  # Cria a data com horário no padrao brasileiro e permanece aceitando no formato tradicional.
  #
  # Exemplo:
  # "27/09/2007 01:23".to_date
  alias_method :_original_to_time, :to_time

  def to_time
    if /^(0?[1-9]|[12]\d|3[01])\W(0?[1-9]|1[012])\W(\d{4})(\W([01]?\d|2[0123])\W([0-5]?\d)\W?([0-5]\d)?)?$/ =~ self
      ::Time.mktime($3.to_i, $2.to_i, $1.to_i, $5.to_i, $6.to_i, $7.to_i)
    else
      _original_to_time
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

