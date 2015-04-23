class RenameColumnByCoursewareType < ActiveRecord::Migration
  def change
 	  rename_column :coursewares, :type, :type_of_courseware
  end
end
