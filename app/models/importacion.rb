class Importacion
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :archivo

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value)}
  end

# Metodo necesario al incluir el modulo ActiveModel::Conversion
  def persisted?
    false
  end
# Hash que permite agrupar los headers de archivo a importar
  def mapeo_headers
    @mapping = { bl: {"BL" => :codigo, "ARRIVING DATE" => :fecha_atraque},
                 equipo: {"CONTAINER" => :codigo, "TYPE" => :codigo},
                 consignatario: {"CONSIGNEE" => :nombre},
                 embarcador: {"SHIPPER" => :nombre }
                }
  end

  def guardar
    if elementos_importados.map(&:valid?).all?
      elementos_importados.each(&:save!)
      true
    else
      elementos_importados.each_with_index do |elm, index|
        elm.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def elementos_importados
    @elementos_importados ||= cargar_importados
  end


  def cargar_importados
    hoja = abrir_hoja
    cabezera = hoja.row(1)
    (2..hoja.last_row).map do |i|
      row = Hash[[cabezera, hoja.row(i)].transpose]
      # FIX: Refactor para contemplar multiples modelos
      bl = Bl.find_by(codigo: row["BL"]) || Bl.new
      hash = row.to_hash.slice("BL", "ARRIVING DATE")
      bl.attributes = Hash[hash.map { |k,v| [mapeo_headers[:bl][k], v] }]
      bl
    end
  end

  def abrir_hoja
    case File.extname(archivo.original_filename)
    when ".csv" then Roo::Csv.new(archivo.path, nil)
    when ".xls" then Roo::Excel.new(archivo.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(archivo.path, nil, :ignore)
    when ".ods" then Roo::LibreOffice.new(archivo.path, nil, :ignore)
    else raise "Tipo de archivo desconocido: #{archivo.original_filename}"
    end
  end
end