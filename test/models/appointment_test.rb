require "test_helper"

describe Appointment do
  let(:appointment) { build(:appointment) }

  describe "关于预约报名节目" do
    # it "节目都开始了，应该不能报名了" do
    #   program = appointment.program
    #   if Time.now > program.online_date
    #     appointment.save
    #     appointment.state.must_equal 2
    #   end
    # end

    it " 同一个用户对于同一个节目最多只能预约一次" do
      user = appointment.user
      program = appointment.program
      appointment.save
      invalid_appointment = user.appointments.build(:user_id => user.id, :program_id => program.id)
      invalid_appointment.must_be :invalid?
    end

    it "预约报名后，并完成节目，参与节目的对应积分应该乘以系数2，乘以系数原因为提前预约报名" do
      flunk "Need Real Test"
    end

    it "预约报名后，如果节目已下线，即便观看了录播积分应该不变" do
      flunk "Need Real Test"
    end
  end
end
