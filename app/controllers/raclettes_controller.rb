class RaclettesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
      redirect_to dashboard_path, notice: "Machine bien enregistré"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @raclette = Raclette.find(params[:id])
  end

  def update
    @raclette = Raclette.find(params[:id])

    if @raclette.update(raclette_params)
      redirect_to dashboard_path, notice: "mise à jour effectuée !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @raclette = Raclette.find(params[:id])
    @raclette.destroy
    redirect_to dashboard_path, notice: "Raclette supprimée"
  end

  private

  def raclette_params
    params.require(:raclette).permit(:category, :capacity, :description, :price, :photo)
  end
end
