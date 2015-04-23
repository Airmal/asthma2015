class Purchase < ActiveRecord::Base
  belongs_to :program
  belongs_to :admin

  STATE = {
    init: 0, # 未请购
    purchased: 1, # 已请购未审批
    approved: 2, # 审批通过
    expired: 3, # ???
    deleted: -1 # 软删除
  }
end
