class Api::V1::VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  def index
    @vehicles = Vehicle.all
    render json: { status: 'Success', message: 'Loaded vehicles', data: @vehicles }, status: :ok
  end

  def show
    render json: { status: 'Success', message: 'Loaded vehicles', data: @vehicle }, status: :ok
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      render json: {status: 'Success',message: 'Created Vehicle', data: @vehicle},status: :ok
    else
      render json: {status: 'Failure', message: 'Could not create vehicle!', data: @vehicle},status: :unauthorized
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      render json: {status: 'Sucess', message: 'Updeted Vehicle Succesfully',data: @vehicle},status: :ok
    else
      render json: {status: 'Failure', errors: @vehicle.errors.full_messages, data: @vehicle}, status: :unauthorized
    end
  end

  def destroy
    if @vehicle.destroy
        render json: {status: 'Sucess', message: 'Deleted Vehicle Succesfully',data: @vehicle},status: :ok
    else
      render json: {status: 'Failure', errors: @vehicle.errors.full_messages, data: @vehicle}, status: :unauthorized
    end
  end

  private
  def set_vehicle
    @vehicle = Vehicle.find_by(id: params[:id])
  end

  def vehicle_params
    params.permit(:brand,:model,:price,:image,:description)
  end
end
