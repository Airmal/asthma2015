class AddColumToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :administrator_name, :string, :comment => '管理员名称'
  	add_column :admins, :originize_name, :string, :comment => '机构名称'
  	add_column :admins, :administrator_flg, :string, :comment => '管理员FLG'
  end
end
