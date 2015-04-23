class RemoveColumnsAboutFilePath < ActiveRecord::Migration
  def change
    remove_column :coursewares, :file_path
  end
end
