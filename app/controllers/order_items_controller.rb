class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create    
  @user = current_user
  @product =  Product.find(params[:product])
 
    if @product.quantity > 0 
      @order = @user.orders
      date = @order.find_by(date: Date.current)
        if date
          orderitem = date.order_items.find_by(product_id: @product.id)
                    
            if orderitem
              orderitem.update(quantity: orderitem.quantity+=1, total_price: @product.price*orderitem.quantity)
              @product.update(quantity: @product.quantity-=1)
              redirect_to users_order_path(id: date.id), notice: "ready to purchase"
            else                
              @orderitem = @product.order_items.new(order_id: date.id, total_price: @product.price*1)
              @product.update(quantity: @product.quantity-=1)

              if @orderitem.save
                UserMailer.order_email(@user, @orderitem).deliver
                # SendEmailsJob.perform_now(@user)
                redirect_to users_order_path(id: date.id), notice: "ready to purchase"
              else
                redirect_to @product, alert: "something wrong"
              end
            end 

        else 
          @order = @user.orders.create(date: Date.current)
          @orderitem = @product.order_items.new(order_id: @order.id, total_price: @product.price*1) 
          @product.update(quantity: @product.quantity-=1)

          if @orderitem.save
            UserMailer.order_email(@user).deliver
            redirect_to users_order_path(id: @order.id), notice: "ready to purchase"
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
    @order = current_user.orders
    date = @order.find_by(date: Date.current)
    @orderitem = date.order_items

    orderitem = @orderitem.find_by(product_id: @product.id) 

    orderitem.destroy
    @product.update(quantity: @product.quantity+orderitem.quantity)
    redirect_to users_order_path(id: date.id), status: :see_other
  end

  def increment_items
    @product =  Product.find(params[:product_id])
    @order = current_user.orders
    date = @order.find_by(date: Date.current)
    @orderitem = date.order_items
     
    orderitem = @orderitem.find_by(product_id: @product.id) 
    if @product.quantity >= 1

      orderitem.update(quantity: orderitem.quantity+=1, total_price: @product.price*orderitem.quantity)
      @product.update(quantity: @product.quantity-=1)
      redirect_to users_order_path(@orderitem)

    else
      redirect_to users_order_path(@orderitem), alert: "product out of stock" 
  
    end
  end

  def decrement_items
   
    @product =  Product.find(params[:product_id])
    @order = current_user.orders
    date = @order.find_by(date: Date.current)
    @orderitem = date.order_items
     
    orderitem = @orderitem.find_by(product_id: @product.id) 

    if orderitem.quantity > 1

      orderitem.update(quantity: orderitem.quantity-=1, total_price: @product.price*orderitem.quantity)
      @product.update(quantity: @product.quantity+orderitem.quantity)
      redirect_to users_order_path(@orderitem)

    else

      orderitem.destroy
      @product.update(quantity: @product.quantity+orderitem.quantity)
      redirect_to users_order_path(@orderitem)

    end
  end

end


