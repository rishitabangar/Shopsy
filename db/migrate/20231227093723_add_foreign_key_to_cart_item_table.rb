class AddForeignKeyToCartItemTable < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:cart_items, :product_id)
      change_table :cart_items do |t|
        t.references :product, foreign_key: true
      end
    end
  end
end
