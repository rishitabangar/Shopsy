class ApplicationController < ActionController::Base
  before_action :current_cart
  before_action :get_session_items, if: -> { user_signed_in? && @current_cart.present?}

  def get_session_items
    @useritem = []
    @current_cart.cart_items.map do |c|
      @useritem << current_user.cart.cart_items.find_or_create_by(product_id: c.product.id, quantity: c.quantity, total_price: c.product.price*c.quantity) 
    end 
    @current_cart.destroy
  end

  private
    def current_cart
      if session[:cart_id]
        cart = Cart.find_by(id: session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end

  protected
    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to new_user_session_path, :alert => 'You need to sign in or sign up before continuing.'
      end
    end  
end
