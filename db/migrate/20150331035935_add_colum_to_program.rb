class AddColumToProgram < ActiveRecord::Migration
  def change
  	add_column :programs, :administrator_id, :integer, :comment => '管理员ID'
  	add_column :programs, :maximum, :integer, :comment => '人数上限'
  	add_column :programs, :enroll_num, :integer, :comment => '已报名人数'
  end
end
