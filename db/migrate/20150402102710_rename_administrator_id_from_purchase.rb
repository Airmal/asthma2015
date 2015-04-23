class RenameAdministratorIdFromPurchase < ActiveRecord::Migration
  def change
  	rename_column :purchases, :administrator_id, :admin_id
  end
end
