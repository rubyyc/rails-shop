class ProductsController < ApplicationController
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 10).order("position ASC")
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
      @product.quantity -= 1
      @product.save
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    # current_cart.add_product_to_cart(@product)
    redirect_to root_path, notice: '添加购物车成功'
  end
end
