class Interactive < ActiveRecord::Base
  serialize :selections

  has_many :users_vs_interactives
  has_many :users, :through => :users_vs_interactives

  TYPE = {
    choices: 1, # 选择
    votes: 2  # 投票
  }

  validates :answer, presence: true, if: :judge_type_is_choices?, on: [:create, :update]
  validates :answer, inclusion: { in: :answer_include_selections}
  validates :answer, length: { is: 1 }, if: :judge_multiple?

  def judge_type_is_choices?
   return self.type_of_interactive == TYPE[:choices]	
  end

  def answer_include_selections
   return self.selections
  end

  def judge_multiple?
   return self.multiple
  end
end
