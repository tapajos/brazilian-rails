require File.dirname(__FILE__) + '/spec_helper'

describe Cpf do

  it "should be invalid with malformed number" do 
    numeros = %w(345.65.67.3 567.765-87698 345456-654-01 123456)
    numeros.each do |n|
      cpf = Cpf.new(n)
      cpf.should_not be_valido
    end
  end
  
  it "should be invalid with invalid number" do
    numeros = %w(23342345699 34.543.567-98 456.676456-87 333333333-33 00000000000 000.000.000-00)
    numeros.each do |n|
      cpf = Cpf.new(n)
      cpf.should_not be_valido
    end
  end
  
  it "should be valid with correct number" do
    numeros = %w(111.444.777-35 11144477735 111.444777-35 111444.777-35 111.444.77735)
    numeros.each do |n|
      cpf = Cpf.new(n)
      cpf.should be_valido
    end
  end

  it "should be invalid with a number longer than 11 chars, even if the first 11 char represent a valid cpf number" do
    %w(111.444.777-3500 11144477735AB).each do |n|
      Cpf.new(n).should_not be_valido
    end
  end
  
  it "should return the formated cpf" do
    cpf = Cpf.new("11144477735")
    cpf.to_s.should == "111.444.777-35"
  end
  
  it "should format the received number at instantiation" do
    cpf = Cpf.new("11144477735")
    cpf.numero.should == "111.444.777-35"
  end
  
  it "should be equal to another instance with the same number" do
    Cpf.new("11144477735").should == Cpf.new("111.444.777-35")
  end
  
end
