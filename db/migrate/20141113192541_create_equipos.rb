class CreateEquipos < ActiveRecord::Migration
  def change
    create_table :equipos do |t|
      t.string :codigo
      t.references :tipo_equipo

      t.timestamps
    end
  end
end
