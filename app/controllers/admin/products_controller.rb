class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :require_is_admin

  layout "admin"
  
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 10).order("position ASC")
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "产品发布成功"
      redirect_to admin_products_path
    else
      flash[:alert] = "产品发布失败"
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "产品更新成功"
      redirect_to admin_products_path
    else
      flash[:alert] = "产品更新失败"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.delete
    flash[:notice] = "产品删除成功"
    redirect_to admin_products_path
  end

  def move_up
    @product = Product.find(params[:id])
    @product.move_higher
    redirect_to admin_products_path
  end

  def move_down
    @product = Product.find(params[:id])
    @product.move_lower
    redirect_to admin_products_path
  end


  protected

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end

  def require_is_admin
    if !current_user.is_admin?
      flash[:alert] = "暂无权限"
      redirect_to root_path
    end
  end
end
