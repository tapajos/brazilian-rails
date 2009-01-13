require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Pessoa < ActiveRecord::Base
  usar_como_cpf :cpf
  validates_uniqueness_of :cpf
end

describe "Using a model attribute as Cpf" do

  before(:each) do
    @person = Pessoa.new(:nome => "Fulano")
  end
  
  it "should format the received number" do
    @person.cpf = "11144477735"
    @person.cpf.numero.should == "111.444.777-35"
  end
  
  it "should respond to cpf_valido?" do
    @person.respond_to?('cpf_valido?').should be_true
  end
  
  it "should be invalid with an invalid cpf number" do
    @person.cpf = "123545"
    @person.should_not be_valid
  end
  
  it "should be invalid with a too long number" do
    @person.cpf = "123456678654454"
    @person.should_not be_valid
  end
  
  it "should be valid with an empty string in the constructor of an instance of Cpf" do
    @person.cpf = Cpf.new("")
    @person.should be_valid
  end
  
  it "should be valid with an empty string as the cpf number" do
    @person.cpf = ""
    @person.should be_valid
  end
  
  it "should not save the instance with an invalid cpf" do
    @person.cpf = "sdwewe"
    @person.save.should be_false
  end
  
  it "should have an error in the cpf field when invalid" do
    @person.cpf = "232df"
    @person.save.should be_false
    @person.errors['cpf'].should == "numero invalido"   
  end
  
  it "should be valid with a null cpf number" do
    @person.cpf = nil
    @person.should be_valid
  end
  
  it "should accept an instance of Cpf" do
    @person.cpf = Cpf.new("11144477735")
    @person.cpf.should be_instance_of(Cpf)
  end
  
  it "should be able to receive parameters at initialization" do
    @person = Pessoa.new(:cpf => "111.44477735")
    @person.cpf.numero.should == "111.444.777-35"  
  end
  
  it "should change the current attribute's value" do
    @person.cpf = Cpf.new("13434")
    lambda {
      @person.cpf = Cpf.new("111.444.777-35")    
    }.should change(@person, :cpf)
  end
end

describe "using validations" do
  it "should validate presence of cpf" do
    Pessoa.validates_presence_of :cpf
    p = Pessoa.new(:nome => "Fulano")
    p.should_not be_valid
    p.errors.on(:cpf).should eql("can't be blank")
  end

  it "should validate uniqueness of cpf" do
    p1 = Pessoa.new(:nome => "Fulano", :cpf => "11144477735")
    p1.save
    puts p1.inspect
    p2 = Pessoa.new(:nome => "Beltrano", :cpf => "11144477735")
    p2.valid?
    p p2.errors
    p2.should_not be_valid
    p2.errors.on(:cpf).should_not be_nil
  end
end
