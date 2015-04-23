class UsersVsInteractive < ActiveRecord::Base
  belongs_to :user
  belongs_to :interactive

  validate :judge_options?, on: [:update]

  def judge_options?
	  errors.add :options, "单选时用户选项数不能多于1个" if self.options.size > 1 && !self.interactive.multiple
  end
end
	