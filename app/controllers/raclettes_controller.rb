class RaclettesController < ApplicationController
  def index
    @raclettes = Raclette.all
  end
end
