class AddAttachmentCoursewareFileToCoursewares < ActiveRecord::Migration
  def self.up
    change_table :coursewares do |t|
      t.attachment :courseware_file
    end
  end

  def self.down
    remove_attachment :coursewares, :courseware_file
  end
end
