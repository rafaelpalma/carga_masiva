class CreateBls < ActiveRecord::Migration
  def change
    create_table :bls do |t|
      t.string :codigo
      t.date :fecha_atraque
      t.timestamps
    end
  end
end
