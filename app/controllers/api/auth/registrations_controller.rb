class Api::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :verify_authenticity_token, if: :devise_controller?
    
    private

    def sign_up_params
        params.permit(:uid, :username, :email, :password, :password_confirmation)
    end
end