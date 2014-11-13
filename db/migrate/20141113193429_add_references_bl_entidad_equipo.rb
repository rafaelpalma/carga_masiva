class AddReferencesBlEntidadEquipo < ActiveRecord::Migration
  def change
    add_reference :equipos, :bl
    add_reference :bls, :entidad
  end
end
