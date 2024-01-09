<!-- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

class ProductsController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
    @products = @category.products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id]) 
    @product = Product.new
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)

    
    if @product.save     
      redirect_to category_product_path(params[:category_id], @product)
    else
      render :new
    end

  end

  def edit
    @category = Category.find(params[:category_id]) 
    @product = @category.products.find(params[:id])
  end
  
  def update
 
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
 
    if @product.update(product_params)     
      redirect_to category_product_path(params[:category_id], @product)
    else
      render :edit
    end

  end

  def destroy
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])

    @product.destroy
    redirect_to category_product_path(@category), status: :see_other
  end

  def all_products
    @products = Product.all
  end

  def get_products
    @product = Product.find(params[:id])
  end

  private 
  def product_params 
    params.require(:product).permit(:name, :description, :price, :image)
  end
  








      <div class="container">
      <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
        <div class="col-md-3 mb-2 mb-md-0">
          <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
            Shopsy
          </a>
        </div>

        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
          <li><a href="#" class="nav-link px-2 link-secondary">Home</a></li>
          <li><a href="#" class="nav-link px-2">Features</a></li>
          <li><a href="#" class="nav-link px-2">Pricing</a></li>
          <li><a href="#" class="nav-link px-2">FAQs</a></li>
          <li><a href="#" class="nav-link px-2">About</a></li>
        </ul>

        <div class="col-md-3 text-end">
          <button type="button" class="btn btn-outline-primary me-2">Login</button>
          <button type="button" class="btn btn-primary">Sign-up</button>
        </div>
      </header>

      <% if notice %>
        <p class="alert alert-success"><%= notice %></p>
      <% end %>
      <% if alert %>
        <p class="alert alert-danger"><%= alert %></p>
      <% end %>


   <% if user_signed_in? %>
      <%= button_to "Sign Out", destroy_user_session_path, :method => :delete %>
    <% else %>
      <%= button_to "Sign In", new_user_session_path %>
    <% end %>

     <%= link_to "cart", users_carts_path(@cart_items) %> 
    <%= link_to "My Orders", users_orders_path(@orderitem) %>
    <%= link_to "Profile", profile_show_path(@user) %>
end -->