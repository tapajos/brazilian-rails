class CreateCarteiras < ActiveRecord::Migration
  def self.up
    create_table :carteiras do |t|
      t.decimal :saldo, :precision => 18, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :carteiras
  end
end
