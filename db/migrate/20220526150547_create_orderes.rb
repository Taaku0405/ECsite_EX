class CreateOrderes < ActiveRecord::Migration[6.1]
  def change
    create_table :orderes do |t|
      t.integer :customer_id
      t.string :address
      t.string :postal_code
      t.integer :charge
      t.string :name
      t.integer :total_payment
      t.integer :payment_method, default: "0"
      t.integer :order_status, default: "0"

      t.timestamps
    end
  end
end
