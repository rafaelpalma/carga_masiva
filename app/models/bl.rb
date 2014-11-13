class Bl < ActiveRecord::Base

  def self.importar(archivo)
    hoja_calculo = abrir_hoja(archivo)
    cabezera = hoja_calculo.row(1)
    (2..hoja_calculo.last_row).each do |num|
      row = Hash[[cabezera, hoja_calculo.row(num)].transpose]
      Bl.find_or_create_by!(codigo: row["codigo"]) do |obj|
        obj.attributes = row.to_hash
      end
    end
  end

  def self.abrir_hoja(archivo)
    case File.extname(archivo.original_filename)
    when ".csv" then Roo::Csv.new(archivo.path, nil)
    when ".xls" then Roo::Excel.new(archivo.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(archivo.path, nil, :ignore)
    when ".ods" then Roo::LibreOffice.new(archivo.path, nil, :ignore)
    else raise "Tipo de archivo desconocido: #{archivo.original_filename}"
    end
  end

  # def self.importar(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     Bl.create!(row.to_hash)
  #   end
  # end
end
