class AddColumntoOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :date, :date
  end
end
