class AddInvitateCdToAppoint < ActiveRecord::Migration
  def change
  	add_column :appointments, :invitate_cd, :string, :comment => '邀请码CD'
  end
end
