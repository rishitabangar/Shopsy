class ProfileController < ApplicationController
  def show
    @user = current_user
    @cart_items = current_user.cart.cart_items
  end
end
