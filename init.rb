%w(feriado 
feriado_parser 
active_record_portuguese
action_view_portuguese
date_portuguese
time_portuguese
dinheiro
dinheiro_util
excecoes
nil_class
number_portuguese
string_portuguese
dinheiro_active_record
busca_endereco).each {|req| require req}

ActiveRecord::Base.send :include, DinheiroActiveRecord

old_verbose = $VERBOSE
$VERBOSE = nil
[Time, Date].each do |clazz|
  eval "#{clazz}::MONTHNAMES = [nil] + %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)"
  eval "#{clazz}::DAYNAMES = %w(Domingo Segunda-Feira Terça-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sábado)"
  eval "#{clazz}::ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)"
  eval "#{clazz}::ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)"
end

FERIADOS_PATH = RAILS_ROOT + '/config/feriados'
feriados, metodos = FeriadoParser.parser(File.dirname(__FILE__) + "/lib/config")
if File.directory?(FERIADOS_PATH)
  f, m = FeriadoParser.parser(FERIADOS_PATH)
  feriados += f
  metodos += m
end
Date::FERIADOS = feriados;
Date::FERIADOS_METODOS = metodos
$VERBOSE = old_verbose
