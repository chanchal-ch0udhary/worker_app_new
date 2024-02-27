class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :configure_permitted_parameters_update, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, alert: exception.message
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, 
                                                            :password,
                                                            :password_confirmation, 
                                                            :name, 
                                                            :role, 
                                                            :phone_no ,
                                                            :address,
                                                            :bio,
                                                            :image])
    end

    def configure_permitted_parameters_update
        devise_parameter_sanitizer.permit(:account_update, keys: [  :email, 
                                                                    :password,
                                                                    :password_confirmation, 
                                                                    :name, 
                                                                    :role, 
                                                                    :phone_no ,
                                                                    :address,
                                                                    :bio,
                                                                    :image])
    end
    
end
