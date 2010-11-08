require 'test_helper'

class CpfTest < ActiveSupport::TestCase

  test "should be invalid with malformed number" do 
    numeros = %w(345.65.67.3 567.765-87698 345456-654-01 123456)
    numeros.each do |n|
      cpf = Cpf.new(n)
      assert !cpf.valido?
    end
  end

  test "should be invalid with invalid number" do
    numeros = %w(23342345699 34.543.567-98 456.676456-87 333333333-33 00000000000 000.000.000-00)
    numeros.each do |n|
      cpf = Cpf.new(n)
      assert !cpf.valido?
    end
  end
  
  test "should be valid with correct number" do
    numeros = %w(111.444.777-35 11144477735 111.444777-35 111444.777-35 111.444.77735)
    numeros.each do |n|
      cpf = Cpf.new(n)
      assert cpf.valido?
    end
  end
  
  test "should be invalid with a number longer than 11 chars, even if the first 11 char represent a valid cpf number" do
    %w(111.444.777-3500 11144477735AB).each do |n|
      assert !Cpf.new(n).valido?
    end
  end
  
  test "should return the formated cpf" do
    cpf = Cpf.new("11144477735")
    assert_equal cpf.to_s, "111.444.777-35"
  end
  
  test "should format the received number at instantiation" do
    cpf = Cpf.new("11144477735")
    assert_equal cpf.numero ,"111.444.777-35"
  end
  
  test "should be equal to another instance with the same number" do
    assert_equal Cpf.new("11144477735"), Cpf.new("111.444.777-35")
  end
  
end
