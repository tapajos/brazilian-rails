require 'active_record_portuguese'
require 'action_view_portuguese'
require 'date_portuguese'
require 'dinheiro'
require 'dinheiro_util'
require 'excecoes'

Time.send(:include, DateUtils)
Numeric.send(:include, DinheiroUtil)
String.send(:include, DinheiroUtil)
