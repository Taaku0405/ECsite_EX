class RenamePostNumberColumToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :post_number, :postal_code
  end
end
