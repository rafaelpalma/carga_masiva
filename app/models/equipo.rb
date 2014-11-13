class Equipo < ActiveRecord::Base

  belongs_to :tipo, class_name: "TipoEquipo"
  belongs_to :bl
end
