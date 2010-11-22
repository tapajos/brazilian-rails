# encoding: UTF-8
require File.dirname(__FILE__) + "/test_helper"
require File.dirname(__FILE__) + "/active_record/base_without_table"

class DinheiroActiveRecordTest < ActiveSupport::TestCase

  class Carteira < ActiveRecord::BaseWithoutTable
    column :saldo, :decimal
    usar_como_dinheiro :saldo
  end

  def setup
    @carteira = Carteira.new
  end

  test "Se aceita dinheiro" do
    @carteira.saldo = 8.reais
    assert @carteira.save
    assert_equal 8.reais, @carteira.saldo
  end

  test "Se aceita número" do
    @carteira.saldo = 30
    assert @carteira.save
    assert_equal 30.reais, @carteira.saldo
  end

  test "Se rejeita valor inválido" do
    @carteira.saldo = 30
    assert @carteira.save
    @carteira.saldo = 'bla'
    assert !@carteira.save
    assert_equal ["O valor deve estar preenchido e no formato correto. Ex.: 100.00 ."], @carteira.errors['saldo']
  end

  test "Se trata nulo corretamente" do
    assert_nil @carteira.saldo
    @carteira.saldo = nil
    assert_nil @carteira.saldo
    @carteira.save
    assert_nil @carteira.saldo
  end

  test "Se cria carteira corretamente quando recebe params" do
    carteira = Carteira.new(:saldo => "1")
    assert_equal 1.real, carteira.saldo
  end

end

