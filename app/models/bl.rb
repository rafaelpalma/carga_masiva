class Bl < ActiveRecord::Base
  

  def self.importar(file)
    CSV.foreach(file.path, headers: true) do |row|
      Bl.create!(row.to_hash)
    end
  end
end
