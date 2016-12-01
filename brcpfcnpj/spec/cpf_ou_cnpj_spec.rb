# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/spec_helper'

describe CpfOuCnpj do

  it "should be invalid with malformed cnpj number" do
    numeros = %w(04.22A.284/0001-11 04.222-284.0001-11 04222/284/0001-11)
    numeros.each do |n|
      cliente = CpfOuCnpj.new(n)
      cliente.should_not be_valido
    end
  end
  
  it "should be invalid with malformed cpf number" do
    numeros = %w(345.65.67.3 567.765-87698 345456-654-01 123456)
    numeros.each do |n|
      cliente = CpfOuCnpj.new(n)
      cliente.should_not be_valido
    end
  end  

  it "should be invalid with invalid cnpj number" do
    numeros = %w(69103604020160 00000000000000 69.103.604/0001-61 01618211000264)
    numeros.each do |n|
      cliente = CpfOuCnpj.new(n)
      cliente.should_not be_valido
    end
  end

  it "should be invalid with invalid cpf number" do
    numeros = %w(23342345699 34.543.567-98 456.676456-87 333333333-33 00000000000 000.000.000-00)
    numeros.each do |n|
      cliente = CpfOuCnpj.new(n)
      cliente.should_not be_valido
    end
  end  

  it "should be invalid with a number longer than 14 chars, even if the first 14 represent a valid number" do
    %w(691036040001-601 69103604000160a 69103604000160ABC 6910360400016000).each do |n|
      CpfOuCnpj.new(n).should_not be_valido
    end
  end
  
  it "should be invalid with a number longer than 11 chars, even if the first 11 char represent a valid cpf number" do
    %w(111.444.777-3500 11144477735AB).each do |n|
      CpfOuCnpj.new(n).should_not be_valido
    end
  end  

  it "should be valid with correct cnpj number" do
    numeros = %w(69103604000160 69.103.604/0001-60 01518211/000264 01.5182110002-64 00.000.000/1447-89)
    numeros.each do |n|
      cnpj = CpfOuCnpj.new(n)
      cnpj.should be_valido
    end
  end
  
  it "should be valid with correct cpf number" do
    numeros = %w(111.444.777-35 11144477735 111.444777-35 111444.777-35 111.444.77735)
    numeros.each do |n|
      cpf = CpfOuCnpj.new(n)
      cpf.should be_valido
    end
  end  

  it "should return the formated cnpj" do
    cnpj = CpfOuCnpj.new("69103604000160")
    cnpj.to_s.should == "69.103.604/0001-60"
  end

  it "should format the received number at instantiation" do
    cnpj = CpfOuCnpj.new("69103604000160")
    cnpj.numero.should == "69.103.604/0001-60"
  end

  it "should be equal to another instance with the same number" do
    CpfOuCnpj.new("69103604000160").should == CpfOuCnpj.new("69.103.604/0001-60")
  end

  it "should return the formated cpf" do
    cpf = CpfOuCnpj.new("11144477735")
    cpf.to_s.should == "111.444.777-35"
  end

  it "should format the received number at instantiation" do
    cpf = CpfOuCnpj.new("11144477735")
    cpf.numero.should == "111.444.777-35"
  end

  it "should be equal to another instance with the same number" do
    CpfOuCnpj.new("11144477735").should == CpfOuCnpj.new("111.444.777-35")
  end  
end


