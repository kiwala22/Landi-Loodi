class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from ActionController::ParameterMissing do |exception|
      render json: { message: "Fields should not be blank." }, status: :bad_request
    end


    protected

    def configure_permitted_parameters
        added_attrs = %i[
          username
          phone_number
          email
          password
          password_confirmation
        ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
      end
end
