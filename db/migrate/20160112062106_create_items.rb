class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :public_description
      t.text :internal_description
      t.integer :sale_price
      t.integer :purchase_price
      t.string :store_name
      t.string :street_address
      t.string :city
      t.string :state 
      t.string :country
      t.string :zip 
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
