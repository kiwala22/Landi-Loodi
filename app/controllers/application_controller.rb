class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?


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
