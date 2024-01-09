class CartsController < ApplicationController
  before_action :authenticate_user!, :only => [:all_items]  

  def all_items
    if (current_user && @current_cart) || current_user
      @cart_items = current_user.cart.cart_items 
    else
      @cart_items = @current_cart.cart_items
    end
  end

  def show
    if current_user && @current_cart 
      @cart_items = current_user.cart.cart_items
    elsif current_user
      @cart_items = current_user.cart.cart_items
    else
      @cart_items = @current_cart.cart_items
    end
  end

end
