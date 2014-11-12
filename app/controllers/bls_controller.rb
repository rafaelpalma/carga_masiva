class BlsController < ApplicationController

  def index
    @bls = Bl.all
  end
end
