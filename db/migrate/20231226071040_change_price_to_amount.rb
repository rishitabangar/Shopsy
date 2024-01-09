class ChangePriceToAmount < ActiveRecord::Migration[7.1]
  def change
    rename_column :carts, :price, :total_amount
  end
end
