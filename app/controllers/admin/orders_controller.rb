class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :require_is_admin

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    # OrderMailer.notify_ship(@order).deliver!

    redirect_to admin_orders_path
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to admin_orders_path
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    # OrderMailer.notify_cancel(@order).deliver!

    redirect_to admin_orders_path
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to admin_orders_path
  end

  def apply_to_cancel
    @order = Order.find_by_token(params[:id])
    # OrderMailer.apply_cancel(@order).deliver!
    flash[:notice] = "已提交申请"
    redirect_to admin_orders_path
  end
end
