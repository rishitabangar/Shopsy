class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.decimal :total_price, precision: 5, scale:2
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
