require 'active_record_portuguese'
require 'action_view_portuguese'
require 'date_portuguese'
require 'time_portuguese'
require 'dinheiro'
require 'dinheiro_util'
require 'excecoes'
require 'nil_class'


Numeric.send(:include, DinheiroUtil)
String.send(:include, DinheiroUtil)
