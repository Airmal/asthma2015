class UserPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_action

  validate :val_point_if_zero

  def val_point_if_zero
   if self.modulus == 0
    self.modulus = 1
   end
  end
end
