class RenameCutomerIdColumToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :cutomer_id, :customer_id
  end
end
