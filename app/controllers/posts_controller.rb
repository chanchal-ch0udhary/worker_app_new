class PostsController < ApplicationController
    
    load_and_authorize_resource

    before_action :set_post_id, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    def index
        if current_user.role == "contractor"
            @posts = Post.where("user_id = ?", current_user.id).page(params[:page])
            if @posts.empty?
              redirect_to root_path, notice: 'You have not created any job posts yet!'
            end
        else
            @posts = Post.page(params[:page])
        end
    end
    
    def new
        @post=Post.new
    end

    def create
        params[:post][:user_id]=current_user.id
        @post=Post.new(post_params)
        if @post.save!
            redirect_to post_path(@post), notice:'Your Job Post has been created successfully!'
        else
            render :new    
        end    
    end

    def show
    end

    def edit
    end

    def search
        @posts = @posts.where("name LIKE ? or description LIKE ? or vacancy LIKE ? or salary LIKE ? or qualification LIKE ?", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%").page(params[:page])
        respond_to do |format|
              format.html
              format.js   # For AJAX request
        end
    end   

    def update
        if @post.update(post_params)
            redirect_to post_path(@post), notice: 'Your Job Post has been updated successfully!'
        else
            render :edit
        end
    end

    def destroy
        if @post.destroy
            redirect_to posts_path, notice: 'Job Post has been deleted successfully!'
        end    
    end

    private

    def post_params
        params.require(:post).permit(:name, :category_id,:description, :vacancy,:qualification, :user_id, :salary, :Bio,:post_image)
    end

    def set_post_id
        @post = Post.find(params[:id])
    end
end
