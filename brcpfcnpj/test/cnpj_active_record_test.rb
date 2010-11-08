require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Empresa < ActiveRecord::Base
  usar_como_cnpj :cnpj
end

class CnpjActiveRecordTest < ActiveSupport::TestCase

  def setup
    @company = Empresa.new
  end

  test "should format the received number" do
    @company.cnpj = "69103604000160"
    assert_equal @company.cnpj.numero, "69.103.604/0001-60"
  end

  test "should respond to cnpj_valido?" do
    assert_respond_to @company , 'cnpj_valido?'
  end
  
  test "should be invalid with an invalid cnpj number" do
    @company.cnpj = "123545"
    assert !@company.valid?
  end
  
  test "should be invalid with a too long number" do
    @company.cnpj = "12323456678654454"
    assert !@company.valid?
  end
  
  test "should not save the instance with an invalid cnpj" do
    @company.cnpj = "sdwewe"
    assert !@company.save
  end
  
  test "should have an error in the cnpj field when invalid" do
    @company.cnpj = "232df"
    @company.save
    assert !@company.errors[:cnpj].empty?
  end
  
  test "should be valid with a null cnpj number" do
    @company.cnpj = nil
    assert @company.valid?
  end
  
  test "should be valid with an empty string in the constructor of an instance of cnpj" do
    @company.cnpj = Cnpj.new("")
    assert @company.valid?
  end
  
  test "should be valid with an empty string as the cnpj number" do
    @company.cnpj = ""
    assert @company.valid?
  end

  test "should accept an instance of Cnpj" do
    @company.cnpj = Cnpj.new("69103604000160")
    assert @company.cnpj.is_a?(Cnpj)
  end
  
  test "should be able to receive parameters at initialization" do
    @company = Empresa.new(:cnpj => "69103604000160")
    assert_equal @company.cnpj.numero, "69.103.604/0001-60"
  end
  
end
