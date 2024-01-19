class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :addcart       
  has_many :orders
  has_one :cart
  has_many :addresses   
  
  after_create :send_welcome_email

  private
  def send_welcome_email
    SendEmailsJob.perform_now(self)
  end

  
  def addcart
    # self.create_cart!
    @cart = Cart.create(user_id: id)
  end

end
