class ChangeAnswerByInteractive < ActiveRecord::Migration
  def change
  	change_column :interactives, :answer, :text
  end
end
