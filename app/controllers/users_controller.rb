class UsersController < ApplicationController
    before_action :get_user, except: [:new, :create]
    before_action :authenticate_user!, only: [:admin_panel, :edit, :update]
    before_action :authorize_user!, only: [:admin_panel, :edit]
    
    def new
        @user = User.new
    end

    def create
        if params[:is_cook] == 'true'
            @user = User.new params.require(:user).permit(:username, :email, :profile_img_url, :password, :password_confirmation)
            @user.is_cook = true
        elsif params[:is_cook] == 'false'
            @user = User.new params.require(:user).permit(:username, :email, :profile_img_url, :password, :password_confirmation)
            @user.is_cook = false
        end
        if @user.save
            session[:user_id] = @user.id
            flash.notice = 'Signed up!'
            redirect_to root_path
        else
            render :new, status: 303
        end
    end
    
    def show
        
    end

    def admin_panel

    end

    def edit

    end
  
    def update
      if @user.update(params.require(:user).permit(:username, :email, :profile_img_url))
        redirect_to show_admin_panel_user_path(@user)
      else
        render :edit
      end
    end
    
    private
    def get_user
        @user = User.find_by_id(params[:id])
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless params[:id].to_i == current_user.id
    end
end
