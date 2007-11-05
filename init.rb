require 'active_record_portuguese'
require 'action_view_portuguese'
require 'date_portuguese'
require 'time_portuguese'
require 'dinheiro'
require 'dinheiro_util'
require 'excecoes'
require 'nil_class'
require 'number_portuguese'
require 'string_portuguese'
require 'feriado/feriado'
require 'feriado/feriado_parser'

Numeric.send(:include, DinheiroUtil)
Numeric.send(:include, ExtensoReal)
String.send(:include, DinheiroUtil)
String.send(:include, StringPortuguese)

old_verbose = $VERBOSE
$VERBOSE = nil
[Time, Date].each do |clazz|
  eval "#{clazz}::MONTHNAMES = [nil] + %w(Janeiro Fevereiro Marco Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)"
  eval "#{clazz}::DAYNAMES = %w(Domingo Segunda-Feira Terca-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sabado)"
  eval "#{clazz}::ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)"
  eval "#{clazz}::ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)"
end
$VERBOSE = old_verbose

  
