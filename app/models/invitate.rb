class Invitate < ActiveRecord::Base
  belongs_to :user
  belongs_to :program

  STATE = {
    init: 0, # 未发放
    normal: 1, # 已发放未使用
    used: 2, # 已使用
    expired: 3, # 已过期
    deleted: -1 # 软删除
  }
end
