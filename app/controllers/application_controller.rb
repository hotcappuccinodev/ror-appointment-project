class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = :name, { roles: [] }
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def tokenized
    return nil unless params[:authentication_token]

    user = User.find_by_authentication_token(params[:authentication_token])
    sign_in(user)
  end
end
