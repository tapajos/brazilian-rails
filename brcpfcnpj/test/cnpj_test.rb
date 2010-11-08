require File.dirname(__FILE__) + '/test_helper'

class CnpjTest < ActiveSupport::TestCase

  test "should be invalid with malformed number" do
    numeros = %w(04.22A.284/0001-11 04.222-284.0001-11 04222/284/0001-11)
    numeros.each do |n|
      cnpj = Cnpj.new(n)
      assert !cnpj.valido?
    end
  end

  test "should be invalid with invalid number" do
    numeros = %w(69103604020160 00000000000000 69.103.604/0001-61 01618211000264)
    numeros.each do |n|
      cnpj = Cnpj.new(n)
      assert !cnpj.valido?
    end
  end

  test "should be invalid with a number longer than 14 chars, even if the first 14 represent a valid number" do
    %w(691036040001-601 69103604000160a 69103604000160ABC 6910360400016000).each do |n|
      assert !Cnpj.new(n).valido?
    end
  end

  test "should be valid with correct number" do
    numeros = %w(69103604000160 69.103.604/0001-60 01518211/000264 01.5182110002-64 00.000.000/1447-89)
    numeros.each do |n|
      cnpj = Cnpj.new(n)
      assert cnpj.valido?
    end
  end
  
  test "should return the formated cnpj" do
    cnpj = Cnpj.new("69103604000160")
    assert_equal cnpj.to_s, "69.103.604/0001-60"
  end
  
  test "should format the received number at instantiation" do
    cnpj = Cnpj.new("69103604000160")
    assert_equal cnpj.numero, "69.103.604/0001-60"
  end
  
  test "should be equal to another instance with the same number" do
    assert_equal Cnpj.new("69103604000160"), Cnpj.new("69.103.604/0001-60")
  end  
  
end
