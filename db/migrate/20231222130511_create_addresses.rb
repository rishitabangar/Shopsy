class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.text :address_line1
      t.text :address_line2
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.boolean :primary 
      t.boolean :home
      t.boolean :office

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
