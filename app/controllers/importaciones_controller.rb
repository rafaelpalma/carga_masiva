class ImportacionesController < ApplicationController

  def new
    @importacion = Importacion.new
  end

  def create
    @importacion = Importacion.new(params[:importacion])
    if @importacion.guardar
      redirect_to new_importaciones_path, notice: "Archivo importado"
    else
      render :new
    end
  end
end
