class CartItemsController < ApplicationController
before_action :check_cartitem, :only => [:destroy, :increment, :decrement]
before_action :mergecart, :only => [:create], if: -> { user_signed_in? && @current_cart.present?}


  def create
    if current_user ? @cart = current_user.cart : @cart = @current_cart 
    end 
    @product = Product.find(params[:product])  
    if @product.quantity > 0 
        cartitem = @cart.cart_items.find_by(product_id: @product.id)
      if cartitem
        cartitem.update(quantity: cartitem.quantity+=1, total_price: @product.price*cartitem.quantity)
        @product.update(quantity: @product.quantity-=1)
        redirect_to users_carts_path , notice: "Added to the cart"

      else
        @cartitem = @product.cart_items.new(cart_id: @cart.id, total_price: @product.price*1)
        @product.update(quantity: @product.quantity-=1)
          if @cartitem.save
            redirect_to users_carts_path, notice: "Added to the cart"
          else
            redirect_to @product, alert: "something wrong"
          end
      end

    else
      redirect_to @product, alert: "product out of stock"
    end
  end

  def destroy
    @product =  Product.find(params[:id])
    cartitem = @cartitem.find_by(product_id: @product.id) 

    cartitem.destroy
    @product.update(quantity: @product.quantity+cartitem.quantity)
    redirect_to users_carts_path(@cart), status: :see_other
  end

  def decrement
    @product =  Product.find(params[:product_id])   
    cartitem =  @cartitem.find_by(product_id: @product.id) 
    if cartitem.quantity > 1
      cartitem.update(quantity: cartitem.quantity-=1, total_price: @product.price*cartitem.quantity)
      @product.update(quantity: @product.quantity+cartitem.quantity)
      redirect_to users_carts_path(@cart)
    else
      cartitem.destroy
      @product.update(quantity: @product.quantity+cartitem.quantity)
      redirect_to users_carts_path(@cart)
    end

  end

  def increment
    @product =  Product.find(params[:product_id])   
    cartitem =  @cartitem.find_by(product_id: @product.id) 
    if @product.quantity >= 1
      cartitem.update(quantity: cartitem.quantity+=1, total_price: @product.price*cartitem.quantity)
      @product.update(quantity: @product.quantity-=1)
      redirect_to users_carts_path(@cart)
    else
      redirect_to users_carts_path(@cart), alert: "product out of stock" 
    end

  end

  def check_cartitem
    if (user_signed_in? && @current_cart) || current_user
      @cartitem = current_user.cart.cart_items
    else
      @cartitem = @current_cart.cart_items 
    end
  end
   
  def mergecart 
    @product = Product.find(params[:product])  
    if @product.quantity > 0 
      @useritem.map do |item|
        if item.product_id == @product.id
          item.update(quantity: item.quantity+=1, total_price: @product.price*item.quantity)
          @product.update(quantity: @product.quantity-=1)
          redirect_to users_carts_path , notice: "Added to the cart"  
          return
        else
          @cartitem = @product.cart_items.create(cart_id: current_user.cart.id, total_price:@product.price*1)
          @product.update(quantity: @product.quantity-=1)
          redirect_to users_carts_path, notice: "Added to the cart" 
          return
        end
      end 
    else
      redirect_to @product, alert: "product out of stock"
      return
    end
  end

end

