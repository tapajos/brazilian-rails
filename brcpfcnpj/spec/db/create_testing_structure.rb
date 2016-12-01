# -*- encoding : utf-8 -*-
class CreateTestingStructure < ActiveRecord::Migration
  def self.up
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
    end
    create_table :pessoas do |t|
      t.string :nome
      t.string :cpf
    end
    create_table :companies do |t|
      t.string :nome
      t.string :cnpj
    end
    create_table :people do |t|
      t.string :nome
      t.string :cpf
    end
    create_table :clientes do |t|
      t.string :nome
      t.string :codigo
    end
    create_table :customers do |t|
      t.string :nome
      t.string :codigo
    end
  end

  def self.down
    drop_table :pessoas
    drop_table :empresas
    drop_table :companies
    drop_table :people
    drop_table :clientes
    drop_table :customers
  end
end

