module BrCpfCnpj
  require "rubygems"
  require "active_support"
  require "brcpfcnpj/cpf_cnpj"
  require "brcpfcnpj/cnpj"
  require "brcpfcnpj/cpf"
  require "brcpfcnpj/cpf_cnpj_activerecord"

  if defined?(ActiveRecord)
    ActiveRecord::Base.send :include, CpfCnpjActiveRecord
  end
end

