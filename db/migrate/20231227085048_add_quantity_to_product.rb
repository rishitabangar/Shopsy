class AddQuantityToProduct < ActiveRecord::Migration[7.1]
  def change
    unless column_exists? :products, :quantity
      add_column :products, :quantity, :integer
    end
  end
end
