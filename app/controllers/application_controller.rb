class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:service_id, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :service_id, :avatar])
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
    
    def room_make_check(otheruser)
      currentUserEntry = Entry.where(user_id: current_user.id)
      userEntry = Entry.where(user_id: otheruser.id)
      unless otheruser.id == current_user.id
        currentUserEntry.each do |cu|
          userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
      end
    end

    def follow_for_follow?(otheruser_id)
      otheruser = User.find(otheruser_id)
      @following = current_user.following?(otheruser)
      @follower = otheruser.following?(current_user)
      if @following && @follower
        true
      else
        false
      end
    end
end
