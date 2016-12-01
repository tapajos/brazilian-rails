require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Customer < ActiveRecord::Base
  validates :codigo, :cpf_ou_cnpj => true
end

describe CpfOuCnpjValidator do
  it "should isn't valid when the codigo isn't valid" do
    @customer = Customer.new(:codigo => "12345")
    @customer.valid?.should be_false
    @customer.errors[:codigo].should == ["is invalid"]
  end
  it "should accept a nil codigo" do
    @customer = Customer.new(:codigo => nil)    
    @customer.valid?.should be_true
  end
  it "should be valid with a valid cnpj" do
    @customer = Customer.new(:codigo => "69103604000160")
    @customer.valid?.should be_true
  end
  it "should be valid with a valid cpf" do
    @customer = Customer.new(:codigo => "11144477735")
    @customer.valid?.should be_true
  end
end