class CreateTipoEquipos < ActiveRecord::Migration
  def change
    create_table :tipo_equipos do |t|
      t.string :codigo

      t.timestamps
    end
  end
end
