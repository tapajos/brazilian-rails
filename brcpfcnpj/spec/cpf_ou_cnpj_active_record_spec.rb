# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Cliente < ActiveRecord::Base
  usar_como_cpf_ou_cnpj :codigo
end

describe "Using a model attribute as CpfOuCnpj" do

  before(:each) do
    @cliente = Cliente.new(:nome => "Fulano")
  end

  it "should format the received Cpf" do
    @cliente.codigo = "11144477735"
    @cliente.codigo.numero.should == "111.444.777-35"
  end

  it "should format the received Cnpj" do
    @cliente.codigo = "69103604000160"
    @cliente.codigo.numero.should == "69.103.604/0001-60"
  end

  it "should respond to codigo_valido?" do
    @cliente.respond_to?('codigo_valido?').should be_true
  end

  it "should be invalid with an invalid CpfOuCnpj number" do
    @cliente.codigo = "123545"
    @cliente.should_not be_valid
  end

  it "should be invalid with a too long number" do
    @cliente.codigo = "123456678654454"
    @cliente.should_not be_valid
  end

  it "should be valid with an empty string in the constructor of an instance of CpfOuCnpj" do
    @cliente.codigo = CpfOuCnpj.new("")
    @cliente.should be_valid
  end

  it "should be valid with an empty string as the codigo number" do
    @cliente.codigo = ""
    @cliente.should be_valid
  end

  it "should not save the instance with an invalid codigo" do
    @cliente.codigo = "sdwewe"
    @cliente.save.should be_false
  end

  it "should have an error in the codigo field when invalid" do
    @cliente.codigo = "232df"
    @cliente.save.should be_false
    @cliente.errors[:codigo].should == ["is invalid"]
  end

  it "should be valid with a null codigo number" do
    @cliente.codigo = nil
    @cliente.should be_valid
  end

  it "should accept an instance of CpfCnpj (cpf)" do
    @cliente.codigo = CpfOuCnpj.new("11144477735")
    @cliente.codigo.should be_instance_of(CpfOuCnpj)
  end

  it "should accept an instance of CpfCnpj (cnpj)" do
    @cliente.codigo = CpfOuCnpj.new("69103604000160")
    @cliente.codigo.should be_instance_of(CpfOuCnpj)
  end

  it "should be able to receive parameters at initialization (cpf)" do
    @cliente = Cliente.new(:codigo => "111.44477735")
    @cliente.codigo.numero.should == "111.444.777-35"
  end

  it "should be able to receive parameters at initialization (cnpj)" do
    @cliente = Cliente.new(:codigo => "69.103604000160")
    @cliente.codigo.numero.should == "69.103.604/0001-60"
  end

  it "should change the current attribute's value" do
    @cliente.codigo = CpfOuCnpj.new("13434")
    lambda {
      @cliente.codigo = CpfOuCnpj.new("111.444.777-35")
    }.should change(@cliente, :codigo)
  end
end

describe "when validating" do
  describe "presence" do
    before do
      Cliente.validates_presence_of :codigo
    end

    it "should be invalid with a nil codigo number" do
      c = Cliente.new(:nome => "Fulano", :codigo => nil)
      c.should_not be_valid
      c.errors[:codigo].should eql(["can't be blank"])
    end

    it "should be invalid with an empty string as the codigo number" do
      c = Cliente.new(:nome => "Fulano", :codigo => "")
      c.should_not be_valid
      c.errors[:codigo].should_not be_empty
    end

    it "should be valid with a codigo (cpf)" do
      Cliente.new(:nome => "Fulano", :codigo => "11144477735").should be_valid
    end

    it "should be valid with a codigo (cnpj)" do
      Cliente.new(:nome => "Fulano", :codigo => "69103604000160").should be_valid
    end
  end

  describe "uniqueness" do
    before(:each) do
      Cliente.validates_uniqueness_of :codigo
      @c1 = Cliente.new(:nome => "Beltrano", :codigo => "11144477735")
      @c1.save
    end

    it "should validate uniqueness of codigo" do
      c2 = Cliente.new(:nome => "Beltrano", :codigo => "11144477735")
      c2.should_not be_valid
      c2.errors[:codigo].should_not be_empty
    end

    it "should be valid using a new cpf" do
      c2 = Cliente.new(:nome => "Fulano", :codigo => "00123456797")
      c2.should be_valid
    end
  end
end

