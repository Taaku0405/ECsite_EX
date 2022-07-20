class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :post_number
      t.string :address
      t.string :name
      t.integer :charge
      t.integer :total_payment
      t.integer :payment_method, default: 0
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
