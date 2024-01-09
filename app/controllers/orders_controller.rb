class OrdersController < ApplicationController

  def index
    @order = current_user.orders 
    @orderitems = OrderItem.all
    @cart_items = current_user.cart.cart_items
    
  end

  def show
    @order = current_user.orders    
    @todaysorder = @order.find_by(date: Date.current)
    @orderitems = @todaysorder.order_items
    
  end

end
