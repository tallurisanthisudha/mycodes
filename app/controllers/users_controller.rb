class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.order(created_at: :desc)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "user has been created succesfully"
            redirect_to root_path
        else
          render :new, status: :unprocessable_entity
          flash[:alert] = "user not created,Try again"
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to root_path
            flash[:success] = "user has been updated succesfully"
        else
          render :edit, status: :unprocessable_entity
          flash[:alert] = "user not updated,Try again"
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, status: :see_other
        flash[:success] = "User has been destroyed succesfully"
    end
    

    private
    def user_params
        params.require(:user).permit(:first_name,:last_name,:gender,:username,:date_of_birth,:mobile_number,:email,:password,:password_confirmation, :avatar)
    end

end
