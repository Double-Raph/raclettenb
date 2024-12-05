class RaclettesController < ApplicationController

  def index
    @raclettes = Raclette.all
    @markers = @raclettes.geocoded.map do |raclette|
      {
        lat: raclette.latitude,
        lng: raclette.longitude
      }
    end
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

  def edit
    @raclette = Raclette.find(params[:id])
  end

  def my_raclettes
    @raclettes = current_user.raclettes
  end

  def update
    @raclette = Raclette.find(params[:id])

    if @raclette.update(raclette_params)
      redirect_to my_raclettes_path, notice: "mise à jour effectuée !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @raclette = Raclette.find(params[:id])
    @raclette.destroy
    redirect_to my_raclettes_path, notice: "Raclette supprimée"
  end

  private

  def raclette_params
    params.require(:raclette).permit(:category, :capacity, :description, :price, :photo, :address, :city, :country)
  end
end
