class AddColumnToBl < ActiveRecord::Migration
  def change
    add_column :bls, :entidad_embarcador_id, :integer
  end
end
