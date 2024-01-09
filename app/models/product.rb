class Product < ApplicationRecord
  has_one_attached :image
  has_many :order_items
  has_many :cart_items
  belongs_to :categories
end
