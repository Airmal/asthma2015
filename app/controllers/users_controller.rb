class UsersController < ApplicationController
  before_action :require_user_login, only: :dashboard

  def dashboard
    @user = current_user
    # 当前用户总积分
    @userpoint = @user.total_point

    # 直播节目按照时间顺序由近及远，从db挑选1条记录。
    @liveProgram = Program.where(:live_or_replay => Program::TYPE[:live]).order("online_date").first
  end
end
