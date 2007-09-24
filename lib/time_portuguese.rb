class Time

  old_verbose = $VERBOSE
$VERBOSE = nil
MONTHNAMES = [nil] + %w(Janeiro Fevereiro Marco Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)
DAYNAMES = %w(Domingo Segunda-Feira Terca-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sabado)
ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)
ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)
$VERBOSE = old_verbose
  
  def to_s_br
    strftime("%d/%m/%Y %H:%M")
  end
  
end
