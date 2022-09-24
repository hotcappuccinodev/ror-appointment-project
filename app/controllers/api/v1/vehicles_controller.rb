class Api::V1::VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
    render json: { status: 'Success', message: 'Loaded vehicles', data: @vehicles }, status: :ok
  end

  def show
    @vehicle = Vehicle.find_id(id: param[:id])
    render json: { status: 'Success', message: 'Loaded vehicles', data: @vehicle }, status: :ok
  end

  def create; end
end
