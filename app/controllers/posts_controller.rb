class PostsController < ApplicationController

    before_action :authenticate_user!
   def index
    if current_user
      @posts = Post.order(created_at: :desc)
    else
      redirect_to new_user_session_path
    end
    
   end

  
  def create

      @post = Post.new(post_params)
    
      if @post.save
        redirect_to @post
      else
        render :new, status: :unprocessable_entity
        flash[:notice] = "post has been created."
      end

    end

    def show
        @post = Post.find(params[:id])
    end
      
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
  
      redirect_to user_path(current_user)
    end
    
    def new
      @post = Post.new
    end


    private
      def post_params
        params.require(:post).permit(:description, :image, :user_id)
      end

end
