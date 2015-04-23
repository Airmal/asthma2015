class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
  validates :user_id, :program_id, presence: true
  validates :user_id, uniqueness: { scope: :program_id}
  validates :content, presence: true, if: "!self.rank.present?"
  validates :content, length: { in: 7..140 }
  # before_save :rank_can_not_be_update

  STATE = {
    normal: 1, # 评论成功
    deleted: -1, # 软删除
    blocked: 2, # 屏蔽
  }

  protected
    def rank_can_not_be_update
      user_id = self.user_id
      program_id = self.program_id
      be_comment = Comment.find_by(:user_id => user_id, :program_id => program_id)
      if !be_comment.nil?
        self.rank = be_comment.rank
      end
    end
end
