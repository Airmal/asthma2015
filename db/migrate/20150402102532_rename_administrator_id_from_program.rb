class RenameAdministratorIdFromProgram < ActiveRecord::Migration
  def change
  	rename_column :programs, :administrator_id, :admin_id
  end
end
