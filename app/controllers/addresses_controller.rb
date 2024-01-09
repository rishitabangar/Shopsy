class AddressesController < ApplicationController
  
  def index
    @user = current_user
    @addresses = @user.addresses.all
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @user = current_user
    @address = @user.addresses.new(address_params)
    
    if @address.save     
      redirect_to profile_show_path(@user), notice: "address added successfully"
    else
      render :new
    end

  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @user = current_user
    @address = @user.addresses.find(params[:id])
 
    if @address.update(address_params)     
      redirect_to profile_show_path(@user), notice: "address updated"
    else
      render :edit
    end

  end

  private
  def address_params
    params.require(:address).permit(:address_line1, :address_line2, :city, :state, :country, :pincode, :primary, :home, :office)
  end

end
