class Program < ActiveRecord::Base
  validates :title, :online_date, presence: true

  paginates_per 10 #每页10条记录

  serialize :categories
  serialize :speakers

  has_many :appointments
  has_many :users, :through => :appointments

  has_many :comments
  has_many :users, :through => :comments

  has_many :coursewares
  has_many :uploaders, :class_name => 'User', :through => :coursewares

  has_many :questions
  has_many :askers, :class_name => 'User', :through => :questions

  has_many :purchase
  has_many :invitate

  # before_save :set_default_cover

  has_attached_file :cover, 
    :default_url => 'default.png',
    :url => "/system/programs/:id/:id.:extension",
    :path => ":rails_root/public:url"
    validates_attachment_content_type :cover, :content_type => ["image/jpeg", "image/png"]
    attr_accessor :delete_cover
    before_validation { self.cover.clear if self.delete_cover == '1' }

  def live?
    self.live_or_replay == TYPE[:live]
  end

  def replay?
    self.live_or_replay == TYPE[:replay]
  end

  def offlined?
    Time.now > self.offline_date
  end

  def appoint_state_by_user(user_id)
    appointment = self.appointments.find_by_user_id user_id
    appointment.state if !appointment.nil?
  end

  # 有效的总预约清单
  def valid_total_appointments
    self.appointments.where(:state => Appointment::STATE[:normal])
  end

  TYPE = {
    live: 1, # 直播
    replay: 2 # 录播
  }

  protected
    # 设置默认封面
    def set_default_cover
      self.cover = Settings.default_cover if !self.cover.present?
    end
end
