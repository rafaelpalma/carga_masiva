class Entidad < ActiveRecord::Base

  has_many :bls_consignatario, foreign_key: "entidad_id", class_name: "Bl"
  has_many :bls_embarcador, foreign_key: "entidad_embarcador_id", class_name: "Bl"
end
