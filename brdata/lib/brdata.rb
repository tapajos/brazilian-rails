# encoding: UTF-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'  
require 'action_controller'
require 'active_support'
require 'action_view'
  
%w(date_portuguese
time_portuguese
version
br_date_helper
feriado
feriado_parser
excecoes
).each {|req| require File.dirname(__FILE__) + "/brdata/#{req}"}


module BrData
end

old_verbose = $VERBOSE
$VERBOSE = nil
[Time, Date].each do |clazz|
  eval "#{clazz}::MONTHNAMES = [nil] + %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)"
  eval "#{clazz}::DAYNAMES = %w(Domingo Segunda-Feira Terça-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sábado)"
  eval "#{clazz}::ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)"
  eval "#{clazz}::ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)"
end

$VERBOSE = old_verbose

# FERIADOS_PATH = RAILS_ROOT + '/config/feriados'
feriados, metodos = FeriadoParser.parser(File.dirname(__FILE__) + "/brdata/config")
# if File.directory?(FERIADOS_PATH)
#   f, m = FeriadoParser.parser(FERIADOS_PATH)
#   feriados += f
#   metodos += m
# end
Date::FERIADOS.clear
Date::FERIADOS_METODOS.clear
feriados.each { |f| Date::FERIADOS << f }
metodos.each { |m| Date::FERIADOS_METODOS << m }
