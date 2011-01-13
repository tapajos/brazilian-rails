require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Company < ActiveRecord::Base
  validates :cnpj, :cnpj => true
end

describe CnpjValidator do  
  it "should isn't valid when the cnpj isn't valid" do
    @empresa = Company.new(:cnpj => "12345")
    @empresa.valid?.should be_false
    @empresa.errors[:cnpj].should == ["nao e um CNPJ valido"]
  end
  it "should accept a nil cnpj" do
    @empresa = Company.new(:cnpj => nil)    
    @empresa.valid?.should be_true
  end
  it "should be valid with a valid CNPJ" do
    @empresa = Company.new(:cnpj => "69103604000160")
    @empresa.valid?.should be_true
  end
end