class RemoveColumnsAboutCover < ActiveRecord::Migration
  def change
    remove_column :programs, :cover
  end
end
