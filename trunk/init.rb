require 'active_record_portuguese'
require 'action_view_portuguese'
require 'date_portuguese'
require 'dinheiro_util'
require 'excecoes'

Time.send(:include, DateUtils)

class Numeric
  include DinheiroUtil
end

class String
  include DinheiroUtil
end

