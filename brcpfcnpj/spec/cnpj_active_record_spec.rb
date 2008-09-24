require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Person < ActiveRecord::BaseWithoutTable
  usar_como_cnpj :cnpj
end

describe "Using a model attribute as Cnpj" do

  before(:each) do
    @company = Person.new
  end
  
  it "should format the received number" do
    @company.cnpj = "69103604000160"
    @company.cnpj.numero.should == "69.103.604/0001-60"
  end
  
  it "should respond to cnpj_valido?" do
    @company.respond_to?('cnpj_valido?').should be_true
  end
  
  it "should be invalid with an invalid cnpj number" do
    @company.cnpj = "123545"
    @company.should_not be_valid
  end
  
  it "should be invalid with a too long number" do
    @company.cnpj = "12323456678654454"
    @company.should_not be_valid
  end
  
  it "should not save the instance with an invalid cnpj" do
    @company.cnpj = "sdwewe"
    @company.save.should be_false
  end
  
  it "should have an error in the cnpj field when invalid" do
    @company.cnpj = "232df"
    @company.save
    @company.errors['cnpj'].should == "numero invalido"   
  end
  
  it "should be valid with a null cnpj number" do
    @company.cnpj = nil
    @company.should be_valid
  end
  
  it "should be valid with an empty string in the constructor of an instance of cnpj" do
    @company.cnpj = Cnpj.new("")
    @company.should be_valid
  end
  
  it "should be valid with an empty string as the cnpj number" do
    @company.cnpj = ""
    @company.should be_valid
  end
  
  it "should accept an instance of Cnpj" do
    @company.cnpj = Cnpj.new("69103604000160")
    @company.cnpj.should be_instance_of(Cnpj)
  end
  
  it "should be able to receive parameters at initialization" do
    @company = Person.new(:cnpj => "69103604000160")
    @company.cnpj.numero.should == "69.103.604/0001-60"  
  end
end


