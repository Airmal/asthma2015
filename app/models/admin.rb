class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # 打开或者关闭登录功能
  # :registerable

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:email]
  has_many :purchase

  def title
  	self.administrator_name
  end
end
