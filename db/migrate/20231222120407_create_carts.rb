class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.decimal :price, precision: 10, scale:2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
