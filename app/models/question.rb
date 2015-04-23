class Question < ActiveRecord::Base
  belongs_to :asker, class_name: 'User'
  belongs_to :program
  has_many :replies
  validates :title, :content, :asker_id, :program_id, presence: true

  STATE = {
    normal: 1, # 提问成功
    deleted: -1, # 软删除
    blocked: 2  # 屏蔽
  }

 #  # 获得所有提问
 #  def get_all_questions
 #    question = Question.all
 #  end
   protected
     def format_datetime(date_time)
     	date_time.strftime("%Y.%m.%d %R")
     end
end
