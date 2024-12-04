class PagesController < ApplicationController
  def home
    
    @raclettes = Raclette.includes(:user, :bookings)

    @address = params[:address]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @capacity = params[:capacity]

    if @address.present?
      @raclettes = @raclettes.select do |raclette|
        raclette.user.address&.downcase&.include?(@address.downcase)
      end
    end

    if @capacity.present?
      capacity = @capacity.to_i.clamp(2, 20)
      @raclettes = @raclettes.select do |raclette|
        raclette.capacity >= capacity
      end
    end

    if @start_date.present? && @end_date.present?
      start_date = @start_date.to_date
      end_date = @end_date.to_date
      today = Date.today

      if start_date < today || end_date < today
        flash[:alert] = "Date non valide mon Grailleur"
        redirect_to root_path and return
      end

      @raclettes = @raclettes.reject do |raclette|
        raclette.bookings.any? do |booking|
          booking.start_date <= end_date && booking.end_date >= start_date
        end
      end
    end
  end
end
