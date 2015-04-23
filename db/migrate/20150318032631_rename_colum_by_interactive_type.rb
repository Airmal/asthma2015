class RenameColumByInteractiveType < ActiveRecord::Migration
  def change
 	  rename_column :interactives, :type, :type_of_interactive
  end
end
