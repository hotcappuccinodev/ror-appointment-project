class Api::V1::ReservationsController < ApplicationController
  def index; end

  def show; end

  def create
    @reservation = Reservation.create(user_id: params[:user_id], vehicle_id: params[:vehicle_id], city: params[:city],
                                      date: params[:date])
  end
end
