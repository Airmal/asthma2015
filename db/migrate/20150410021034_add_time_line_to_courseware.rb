class AddTimeLineToCourseware < ActiveRecord::Migration
  def change
    add_column :coursewares, :time_line, :text
  end
end
