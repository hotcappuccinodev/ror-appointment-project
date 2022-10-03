class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: { status: 'Success', message: 'Loaded users', data: @users }, status: :ok
  end
end
