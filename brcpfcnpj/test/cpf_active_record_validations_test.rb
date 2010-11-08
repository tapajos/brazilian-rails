require "test_helper"
require 'active_record/base_without_table'

class Pessoa < ActiveRecord::Base
  usar_como_cpf :cpf
end

class CpfActiveRecordValidationsTest < ActiveSupport::TestCase
  
  def setup
    Pessoa.validates_presence_of :cpf
  end

  def uniq
    Pessoa.validates_uniqueness_of :cpf    
    @p1 = Pessoa.new(:nome => "Beltrano", :cpf => "11144477735")
    @p1.save    
  end

  test "should be invalid with a nil cpf number" do
    p = Pessoa.new(:nome => "Fulano", :cpf => nil)
    assert !p.valid?
    assert !p.errors[:cpf].empty?
  end

  test "should be invalid with an empty string as the cpf number" do
    p = Pessoa.new(:nome => "Fulano", :cpf => "")
    assert !p.valid?
    assert !p.errors[:cpf].empty?
  end
  
  test "should be valid with a cpf" do
    assert Pessoa.new(:nome => "Fulano", :cpf => "11144477735").valid?
  end
  
  test "should validate uniqueness of cpf" do
    uniq
    p2 = Pessoa.new(:nome => "Beltrano", :cpf => "11144477735")
    assert !p2.valid?
    assert !p2.errors[:cpf].empty?
  end
  
  test "should be valid using a new cpf" do
    p2 = Pessoa.new(:nome => "Fulano", :cpf => "00123456797")
    assert p2.valid?
  end
  
end
