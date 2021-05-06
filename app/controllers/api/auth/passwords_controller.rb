class Api::Auth::PasswordsController < DeviseTokenAuth::PasswordsController
    skip_before_action :verify_authenticity_token, if: :devise_controller?
    
end