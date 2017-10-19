class UsersController < ApplicationController
    before_action :require_login, only:[:edit,:update]
    before_action :require_correct_user, only: [:edit, :update]
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to "/events"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to "/"
        end

    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(update_params)
            redirect_to "/events"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to "/users/#{session[:user_id]}"
        end
    end


    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

    def  update_params
        params.require(:user).permit(:first_name, :last_name, :email, :city, :state)
    end

    def require_correct_user
        if User.exists?(params[:id])
            if current_user != User.find(params[:id])
                redirect_to "/users/#{session[:user_id]}/edit"
            end            
        else
            redirect_to "/users/#{session[:user_id]}/edit"
        end
    end
end
