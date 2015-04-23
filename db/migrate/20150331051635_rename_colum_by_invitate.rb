class RenameColumByInvitate < ActiveRecord::Migration
  def change
  	rename_column :invitates, :admin_id, :administrator_id
  end
end
