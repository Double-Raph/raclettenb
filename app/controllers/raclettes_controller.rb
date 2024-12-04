class RaclettesController < ApplicationController
  def index
    @raclettes = Raclette.all
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
    params.require(:raclette).permit(:category, :capacity, :description, :price, :photo)
  end
end
