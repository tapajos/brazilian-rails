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
  end
    
  def self.down
    drop_table :pessoas
    drop_table :empresas
  end
end

