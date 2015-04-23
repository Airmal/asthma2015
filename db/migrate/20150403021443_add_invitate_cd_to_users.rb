class AddInvitateCdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :invitate_cd, :string, :comment => '邀请码CD'
  end
end
