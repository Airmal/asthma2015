class User < ActiveRecord::Base
  has_sms_verification :mobile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :authentication_keys => [:login]

  validates :username, :email, :mobile, :password, presence: true
  validates :username, :email, uniqueness: { :case_sensitive => false }
  validates :mobile, uniqueness: true
  validates :username, length: { in: 4..16 }

  # 序列化使其能存放数组
  serialize :favorite_program_ids

  has_many :appointments
  has_many :programs, :through => :appointments

  has_many :users_vs_interactives
  has_many :interactives, :through => :users_vs_interactives

  has_many :comments
  has_many :programs, :through => :comments

  has_many :coursewares
  has_many :programs, :through => :coursewares

  has_many :user_points
  has_many :user_actions, :through => :user_points

  has_many :questions, :foreign_key => "asker_id"
  has_many :programs, :through => :questions
  has_many :replies, :through => :questions
  has_many :invitate

  # 增加登录账号，以支持同时使用手机、邮箱及用户名登录
  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR mobile = :value", 
        { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  # 累计积分方法
  def earn_point(user_action_id, &conditions)
    point = UserAction.find(user_action_id).point
    modulus = conditions.call()[:modulus] if block_given?
    modulus_reason = conditions.call()[:modulus_reason] if block_given?
    user_point = user_points.create(:user_id => self.id, 
      :user_action_id => user_action_id, 
      :point => point,
      :modulus => modulus || 1,
      :modulus_reason => modulus_reason)
  end

  # 总积分
  def total_point
    total_point = 0
    user_points.each do |user_point|
      total_point += user_point.point * user_point.modulus
    end
    total_point
  end
end
