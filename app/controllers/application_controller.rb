class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = "暂无权限"
      redirect_to root_path
    end
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end
end
