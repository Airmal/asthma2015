class UserAction < ActiveRecord::Base
  has_many :user_points
  has_many :users, :through => :user_points
end
