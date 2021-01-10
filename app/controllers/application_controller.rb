class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:service_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username,:service_id])
    end

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

    def check_guest
      email = resource&.email || params[:user][:email].downcase
      if email == 'guest@example.com'
        redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
      end
    end

    def post_action_user_chk
      if current_user.id != params[:id].to_i
        flash[:notice] = "不正な入力です。"
        redirect_to root_path
      end
    end    
end
