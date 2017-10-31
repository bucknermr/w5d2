class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    # debugger
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def show
    return render :show if find_post

    flash[:errors] = ["Can't find post!"]
    redirect_to subs_url
  end

  def edit
    return render :edit if find_post

    flash[:errors] = ["Can't find post!"]
    redirect_to subs_url
  end

  def update
    find_post
    unless @post.update_attributes(post_params)
      flash[:errors] = @post.errors.full_messages
    else
      redirect_to post_url(@post)
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id[])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def require_author
    redirect_to subs_url unless current_user.posts.find_by(id: params[:id])
  end
end
