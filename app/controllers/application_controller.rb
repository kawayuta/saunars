class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :configure_permitted_parameters, if: :devise_controller?

    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token, if: :devise_controller?

    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
