class RaclettesController < ApplicationController
  def index
    @raclettes = Raclette.all
  end

  def show
    @raclette = Raclette.find(params[:id])
  end

  def new
    @raclette = Raclette.new
  end

  def create
    @raclette = Raclette.new(raclette_params)
    @raclette.user = current_user
    if @raclette.save
      redirect_to raclette_path(@raclette), notice: "Machine bien enregistré"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def raclette_params
    params.require(:raclette).permit(:category, :capacity, :price, :description, :photo)
  end
end
