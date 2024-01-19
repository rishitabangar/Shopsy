class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @cart_items = current_user.cart.cart_items
  end
   
  def show
    # byebug
    @category = Category.find(params[:id])
    @products = Product.where(category: @category.name)
    @cart_items = current_user.cart.cart_items
  end
end
