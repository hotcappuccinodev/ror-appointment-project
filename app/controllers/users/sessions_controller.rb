class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_signed_out_user
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params['email'])

    if @user.valid_password?(params[:password])
      sign_in(@user)
      render json: { status: 'Success', message: 'signed in', data: @user }, status: :ok
    else
      render json: { status: 'failed', message: 'unauthorized' }, status: 401
    end
  end

  # DELETE /resource/sign_out
  def destroy
    @user = current_user
    if @user
      render json: { status: 'Success', message: 'signed out', data: @user }, status: 200
      sign_out(@user)
    else
      render json: { status: 'Failed', message: 'There is no user to sign out' }, status: :unauthorized
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
