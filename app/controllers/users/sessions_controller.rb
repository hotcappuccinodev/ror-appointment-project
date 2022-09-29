class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #skip_before_action :tokenized

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
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
