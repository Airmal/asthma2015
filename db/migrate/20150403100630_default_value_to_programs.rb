class DefaultValueToPrograms < ActiveRecord::Migration
  def change
  	remove_column :programs, :maximum
  	remove_column :programs, :enroll_num
  	add_column :programs, :maximum, :integer, :default => 0, :comment => '人数上限'
  	add_column :programs, :enroll_num, :integer, :default => 0, :comment => '已报名人数'
  end
end
