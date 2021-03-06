class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zip_code, :string
    add_column :users, :country, :string
    add_column :users, :phone_number, :string
    add_column :users, :role, :integer
  end
end
