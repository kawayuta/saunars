class Api::Auth::SessionsController < DeviseTokenAuth::SessionsController
    skip_before_action :verify_authenticity_token, if: :devise_controller?
end