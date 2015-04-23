class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
  validates :user_id, uniqueness: { :scope => :program_id }, if: "self.user_id.present?"
  validate :expired_appointment_state, on: [:create, :update]

  STATE = {
    normal: 1, # 预约成功
    cancelled: 0, # 取消预约
    expired: 2, # 过期
    finished: 3, # ？？
    deleted: -1 # 软删除
  }

  protected

    def expired_appointment_state
      if !self.program.nil? && Time.now > self.program.online_date
        errors.add(:state, "预约状态已过期")
      end
    end
end
