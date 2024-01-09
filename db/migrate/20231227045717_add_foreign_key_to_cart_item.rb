class AddForeignKeyToCartItem < ActiveRecord::Migration[7.1]
  def change
    change_table :cart_items do |t|
      t.references :product, foreign_key: true
    end
  end
end
