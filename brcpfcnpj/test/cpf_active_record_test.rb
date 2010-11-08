require 'test_helper'
require 'active_record/base_without_table'

class Pessoa < ActiveRecord::Base
  usar_como_cpf :cpf
end

class CpfActiveRecordTest < ActiveSupport::TestCase

  def setup
    @person = Pessoa.new(:nome => "Fulano")
  end

  test "should format the received number" do
    @person.cpf = "11144477735"
    assert_equal @person.cpf.numero ,"111.444.777-35"
  end

  test "should respond to cpf_valido?" do
    assert_respond_to @person, 'cpf_valido?'
  end

  test "should be invalid with an invalid cpf number" do
    @person.cpf = "123545"
    assert !@person.valid?
  end
  
  test "should be invalid with a too long number" do
    @person.cpf = "123456678654454"
    assert !@person.valid?
  end
  
  test "should be valid with an empty string in the constructor of an instance of Cpf" do
    @person.cpf = Cpf.new("")
    assert @person.valid?
  end

  test "should be valid with an empty string as the cpf number" do
    @person.cpf = ""
    assert @person.valid?
  end
  
  test "should not save the instance with an invalid cpf" do
    @person.cpf = "sdwewe"
    assert !@person.save
  end
  
  test "should have an error in the cpf field when invalid" do
    @person.cpf = "232df"
    assert !@person.save
    assert_equal @person.errors[:cpf],["numero invalido"]
  end

  test "should be valid with a null cpf number" do
    @person.cpf = nil
    assert @person.valid?
  end
  
  test "should accept an instance of Cpf" do
    @person.cpf = Cpf.new("11144477735")
    assert @person.cpf.is_a?(Cpf)
  end
  
  test "should change the current attribute's value" do
    @person.cpf = Cpf.new("13434")
    assert_difference @person.cpf do
      @person.cpf =  Cpf.new("111.444.777-35")
    end
  end
  
end
