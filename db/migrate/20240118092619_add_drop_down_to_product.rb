class AddDropDownToProduct < ActiveRecord::Migration[7.1]
  def change
    change_table :products do |t|
      t.string :category
    end
  end
end
