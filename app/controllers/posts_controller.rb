class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.turbo_stream { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('post_form', partial: 'posts/form', locals: { post: @post }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.turbo_stream { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('post_form', partial: 'posts/form', locals: { post: @post }) }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'

  rescue ActiveRecord::InvalidForeignKey
    redirect_to @post, alert: 'Post could not be deleted because it has comments.'

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to posts_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
