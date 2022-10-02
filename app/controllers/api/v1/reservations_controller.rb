class Api::V1::ReservationsController < ApplicationController
  before_action :tokenized
  before_action :authenticate_user!
  def index
    @reservations = Reservation.where(user_id: current_user.id)
    render json: { status: 'Success', user: current_user, data: @reservations }, status: :ok
  end

  def show; end

  def create
    @reservation = Reservation.new(user_id: current_user.id, vehicle_id: params[:vehicle_id], city: params[:city],
                                   date: params[:date])
    if @reservation.save
      render json: { status: 'Success', message: 'created reservation', data: @reservation },
             status: :ok
    else
      render json: { status: 'Failed', message: 'Failed to create a new reservation', data: @reservations },
             status: :expectation_failed
    end
  end
end
