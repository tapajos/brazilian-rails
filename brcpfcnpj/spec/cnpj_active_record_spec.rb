require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Empresa < ActiveRecord::Base
  usar_como_cnpj :cnpj
end

describe "Using a model attribute as Cnpj" do

  before(:each) do
    @company = Empresa.new
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
    @company = Empresa.new(:cnpj => "69103604000160")
    @company.cnpj.numero.should == "69.103.604/0001-60"  
  end
end

describe "when validating" do
  before do
    Empresa.validates_presence_of :cnpj
  end

  describe "presence" do
    it "should be invalid with a new cnpj number" do
      e = Empresa.new(:nome => "Bla")
      e.should_not be_valid
      e.errors.on(:cnpj).should eql("can't be blank")
    end


    it "should be invalid using an empty string as the cnpj number" do
      e = Empresa.new(:nome => "Bla", :cnpj => "")
      e.should_not be_valid
      e.errors.on(:cnpj).should_not be_nil
    end

    it "should be valid with a cnpj" do
      Empresa.new(:nome => "Bla", :cnpj => "00012345000165").should be_valid
    end
  end

  describe "uniqueness" do
    before(:each) do
      Empresa.validates_uniqueness_of :cnpj
      @e1 = Empresa.new(:nome => "Bla", :cnpj => "69103604000160")
      @e1.save
    end

    it "should validate uniqueness of cnpj" do
      e2 = Empresa.new(:nome => "Ble", :cnpj => "69103604000160")
      e2.should_not be_valid
      e2.errors.on(:cnpj).should_not be_nil
    end

    it "should be valid using a new cnpj" do
      e2 = Empresa.new(:nome => "Ble", :cnpj => "00012345000165")
      e2.should be_valid                 
    end
  end
end

