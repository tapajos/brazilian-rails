require File.dirname(__FILE__) + '/../../spec_helper'

describe BrCobranca::Boleto::Banco do
  
  def define_expected_handles
    eval "class BrCobranca::Boleto::Banco
      @@handlers = [String]
    end"
  end
  
  before(:each) do
    define_expected_handles
  end
  
  describe ".handlers" do

    it "deve retornar todos os handlers da classe Banco" do
      BrCobranca::Boleto::Banco.handlers.should == [String]
    end

  end
  
  describe ".add_handler" do

    it "deve adicionar mais um handler a classe Banco" do
      BrCobranca::Boleto::Banco.add_handler(Integer)
      BrCobranca::Boleto::Banco.handlers.should == [String, Integer]
    end

  end
  
  describe ".guess" do

    it "Deve retornar uma uma classe quando tiver um handler para o código informado" do
      String.should_receive(:understands_code?).with("code").and_return(true)
      BrCobranca::Boleto::Banco.guess("code").should == String
    end

    it "Deve retornar nil quando não tiver um handler para o código informado" do
      String.should_receive(:understands_code?).with("code").and_return(false)
      BrCobranca::Boleto::Banco.guess("code").should be_nil
    end

  end
  
end
