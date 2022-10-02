class Api::V1::UsersController < ApplicationController
  before_action :tokenized
  before_action :authenticate_user!

  def index
    @users = User.all
    render json: { status: 'Success', message: 'Loaded users', data: @users }, status: :ok
  end
end
