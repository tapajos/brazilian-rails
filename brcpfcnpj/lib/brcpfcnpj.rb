# -*- encoding : utf-8 -*-
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(cpf_cnpj cnpj cpf cpf_ou_cnpj cpf_cnpj_activerecord cnpj_validator cpf_validator cpf_ou_cnpj_validator).each {|req| require File.dirname(__FILE__) + "/brcpfcnpj/#{req}"}

%w(rubygems active_record active_support).each {|req| require req }

ActiveRecord::Base.send :include, CpfCnpjActiveRecord

module BrCpfCnpj
end

