class RaclettesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  @raclettes = Raclette.where.not(latitude: nil, longitude: nil)

  if params[:capacity].present?
    capacity = params[:capacity].to_i
    exact_match = @raclettes.where(capacity: capacity)

    if exact_match.exists?
      @raclettes = exact_match
    else
      @raclettes = @raclettes.where("capacity BETWEEN ? AND ?", capacity - 2, capacity + 2)
    end
  end

  if params[:address].present?
    @raclettes = @raclettes.where("address ILIKE ?", "%#{params[:address]}%")
  end

  @markers = @raclettes.map do |raclette|
    {
      lat: raclette.latitude,
      lng: raclette.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { raclette: raclette }),
      image_url: helpers.asset_path("raclette-icon.png"),
      link: raclette_path(raclette)
    }
  end
  end

  def show
    @raclette = Raclette.find(params[:id])
    @booking = Booking.new
  end

  def new
    @raclette = Raclette.new
  end

  def create
    @raclette = Raclette.new(raclette_params.merge(address: current_user.address, city: current_user.city))
    @raclette.user = current_user

    @raclette.city = current_user.city


    if @raclette.save
      redirect_to dashboard_path, notice: "Appareil bien enregistré !"
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
      redirect_to dashboard_path, notice: "Mise à jour effectuée !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @raclette = Raclette.find(params[:id])
    @raclette.destroy
    redirect_to dashboard_path, notice: "Appareil supprimé"
  end

  private

  def raclette_params
    params.require(:raclette).permit(:category, :capacity, :description, :price, :photo)
  end
end
