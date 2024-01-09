class AddConstraitToCartItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :quantity, :string
    add_column :cart_items, :quantity ,:integer , default: 1
  end
end
