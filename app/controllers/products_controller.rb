class ProductsController < ApplicationController
before_action :mycart

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save     
      redirect_to @product
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def update
 
    @product = Product.find(params[:id])
 
    if @product.update(product_params)     
      redirect_to @product
    else
      render :edit
    end

  end

  def destroy
    @product = Product.find(params[:id])
     
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  def mycart
    if (current_user && @current_cart) || @current_user
      @cart_items = current_user.cart.cart_items
    else
      @cart_items = @current_cart.cart_items
    end
  end

  private 
  def product_params 
    params.require(:product).permit(:name, :description, :category, :price, :quantity, :image)
  end
  
end
