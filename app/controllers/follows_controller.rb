class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_user

    def index
        @follows = Follow.all
    end

    def create
        current_user.follow(@user)
        redirect_to @user
    end
  
    def destroy
        current_user.unfollow(@user)
        redirect_to @user
    end
  
    private
  
    def find_user
        @user = User.find(params[:user_id])
    end
  
end
