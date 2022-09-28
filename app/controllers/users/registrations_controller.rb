class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up

  # POST /resource
  def create
    @user = User.create!(name: params[:name], password: params[:password],
                         password_confirmation: params[:password_confirmation], email: params[:email],
                         roles: params[:roles])
    if @user
      render json: { status: 'Success', message: 'created users', data: @user }, status: :ok
    else
      render json: {
        status: 500,
        message: 'Registration failed'
      }
    end
  end

  # GET /resource/edit

  # PUT /resource

  # DELETE /resource

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.

  # The path used after sign up for inactive accounts.
end
