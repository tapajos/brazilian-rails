require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Person < ActiveRecord::Base
  validates :cpf, :cpf => true
end
describe CpfValidator do  
  it "should isn't valid when the cpf isn't valid" do
    @pessoa = Person.new(:cpf => "12345")
    @pessoa.valid?.should be_false
    @pessoa.errors[:cpf].should == ["nao e um CPF valido"]
  end
  it "should accept a nil cpf" do
    @pessoa = Person.new(:cpf => nil)    
    @pessoa.valid?.should be_true
  end
  it "should be valid with a valid cpf" do
    @pessoa = Person.new(:cpf => "11144477735")
    @pessoa.valid?.should be_true
  end
end