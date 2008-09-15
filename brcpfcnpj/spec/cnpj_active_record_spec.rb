require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Person < ActiveRecord::BaseWithoutTable
  usar_como_cnpj :cnpj
end

describe "Using a model attribute as Cnpj" do

  before(:each) do
    @person = Person.new
  end
  
  it "should format the received number" do
    @person.cnpj = "69103604000160"
    @person.cnpj.numero.should == "69.103.604/0001-60"
  end
  
  it "should respond to cnpj_valido?" do
    @person.respond_to?('cnpj_valido?').should be_true
  end
  
  it "should be invalid with an invalid cnpj number" do
    @person.cnpj = "123545"
    @person.should_not be_valid
  end
  
  it "should be invalid with a too long number" do
    @person.cnpj = "12323456678654454"
    @person.should_not be_valid
  end
  
  it "should not save the instance with an invalid cnpj" do
    @person.cnpj = "sdwewe"
    @person.save.should be_false
  end
  
  it "should have an error in the cnpj field when invalid" do
    @person.cnpj = "232df"
    @person.save
    @person.errors['cnpj'].should == "numero invalido"   
  end
  
  it "should be valid with a null cnpj number" do
    @person.cnpj = nil
    @person.should be_valid
  end
  
  it "should accept an instance of Cnpj" do
    @person.cnpj = Cnpj.new("69103604000160")
    @person.cnpj.should be_instance_of(Cnpj)
  end
  
  it "should be able to receive parameters at initialization" do
    @person = Person.new(:cnpj => "69103604000160")
    @person.cnpj.numero.should == "69.103.604/0001-60"  
  end
end


