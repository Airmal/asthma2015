class AddColumsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :office, :string, :comment => '科室'
  	add_column :users, :company, :string, :comment => '单位'
  	add_column :users, :address, :string, :comment => '单位地址'
  end
end
