class PostsController < ApplicationController
  def index
    @posts = Posts.where(published: true).order(published_at: :desc)
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = currend_user.posts.build(post_params)

    if params[:publish]
      @post.published = true
      @post.published_at = Time.current
    else
      @post.published = false
    end
    if @post.save
      respond_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:publish] && !@post.published
      @post.published = true
      @post.published_at = Time.current
    end
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def check_ownder
      unless @post.user == current_user
      respond_to posts_path, alert: "You are not authorized to perform this action."
      end
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
