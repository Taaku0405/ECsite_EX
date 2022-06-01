class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
     if customer_signed_in?
        root_path
     else
        admin_items_path
     end
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :phone_number])
  end
  
end
