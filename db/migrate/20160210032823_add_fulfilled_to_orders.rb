class AddFulfilledToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer
  end
end
