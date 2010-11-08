require 'test_helper'
require 'active_record/base_without_table'

class Empresa < ActiveRecord::Base
  usar_como_cnpj :cnpj
end

class CnpjActiveRecordValidationsTest < ActiveSupport::TestCase

  def setup
    Empresa.validates_presence_of :cnpj
  end

  def uniq
    Empresa.validates_uniqueness_of :cnpj
    @e1 = Empresa.new(:nome => "Bla", :cnpj => "69103604000160")
    @e1.save
  end

  test "should be invalid with a new cnpj number" do
    e = Empresa.new(:nome => "Bla")
    assert !e.valid?
    assert !e.errors[:cnpj].empty?
  end

  test "should be invalid using an empty string as the cnpj number" do
    e = Empresa.new(:nome => "Bla", :cnpj => "")
    assert !e.valid?
    assert !e.errors[:cnpj].empty?
  end

  test "should be valid with a cnpj" do
    assert Empresa.new(:nome => "Bla", :cnpj => "00012345000165").valid?
  end
  
  test "should validate uniqueness of cnpj" do
    uniq
    e2 = Empresa.new(:nome => "Ble", :cnpj => "69103604000160")
    assert !e2.valid?
    assert !e2.errors[:cnpj].empty?
  end
  
end
