class AddOffsetTimeToCourseware < ActiveRecord::Migration
  def change
    add_column :coursewares, :offset_time, :integer
  end
end
