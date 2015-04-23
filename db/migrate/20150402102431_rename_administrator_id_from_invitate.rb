class RenameAdministratorIdFromInvitate < ActiveRecord::Migration
  def change
  	rename_column :invitates, :administrator_id, :admin_id
  end
end
