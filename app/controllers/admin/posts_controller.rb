class Admin::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :require_is_admin
  def index_bak
    flash[:notice] = "早安！你好！"
    flash[:alert] = "晚安！该睡了！"
    flash[:warning] = "这是 warning 信息！"
    @groups = [
        {
            title: "test title one", description: "test description two"
        },
        {
            title: "test title one", description: "test description two"
        }
    ]
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "文章发表成功"
      redirect_to admin_posts_path
    else
      flash[:alert] = "文章发表失败"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "文章更新成功"
      redirect_to admin_posts_path
    else
      flash[:alert] = "文章更新失败"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    flash[:notice] = "文章删除成功"
    redirect_to posts_path
  end


  protected

  def post_params
    params.require(:post).permit(:title, :content, :tag_ids => [])
  end

  def require_is_admin
    if !current_user.is_admin?
      flash[:alert] = "暂无权限"
      redirect_to root_path
    end
  end
end
