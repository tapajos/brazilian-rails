require File.dirname(__FILE__) + '/../../spec_helper'

describe BrCobranca::Boleto::BancoDoBrasil do
  
  it "deve registrar o Banco do Brasil como um handler" do
    BrCobranca::Boleto::Banco.handlers.include?(BrCobranca::Boleto::BancoDoBrasil).should be_true
  end
  
  describe ".understands_code?" do

    it "deve retornar true se reconhecer o código do Banco do Brasil" do
      BrCobranca::Boleto::BancoDoBrasil.understands_code?("001").should be_true
    end

    it "deve retornar false com outros códigos" do
      BrCobranca::Boleto::BancoDoBrasil.understands_code?("002").should be_false
    end

  end
  
end