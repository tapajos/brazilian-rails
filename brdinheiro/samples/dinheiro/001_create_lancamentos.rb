class CreateLancamentos < ActiveRecord::Migration
  def self.up
    create_table :lancamentos do |t|
      t.column :descricao,  :string,    :null => false
      t.column :valor,      :decimal,   :precision => 14, :scale => 2
    end
  end

  def self.down
    drop_table :lancamentos
  end
end
