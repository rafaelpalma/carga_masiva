class BlsController < ApplicationController

  def index
    @bls = Bl.all
  end

  def importar
    Bl.importar(params[:file])
    redirect_to bls_path, notice: 'El archivo fue cargado'
  end
end
