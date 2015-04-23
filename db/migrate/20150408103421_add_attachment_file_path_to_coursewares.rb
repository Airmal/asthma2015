class AddAttachmentFilePathToCoursewares < ActiveRecord::Migration
  def self.up
    change_table :coursewares do |t|
      t.attachment :file_path
    end
  end

  def self.down
    remove_attachment :coursewares, :file_path
  end
end
