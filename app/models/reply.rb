class Reply < ActiveRecord::Base
  belongs_to :replier, class_name: 'User'
  belongs_to :question
  validates :replier_id, :question_id, :content, presence: true
  validates :best, uniqueness: true, if: :exists_best_reply?, on: [:create, :update]

  # 是否已存在最佳答案
  def exists_best_reply?
    replies = Reply.find_by(:question_id => self.question_id, :best => true)
    return !replies.nil? 
  end
end
