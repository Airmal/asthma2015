require "test_helper"

describe Program, :type => :model do
  let(:program) { build(:program) }

  it "应该有单独访问是直播节目还是录播节目的方法" do
    program.respond_to?(:live?).must_equal true
    program.respond_to?(:replay?).must_equal true
  end

  describe "新建节目时" do
    it "标题不应该为空" do
      program.title = ''
      program.must_be :invalid?
    end

    it "封面如果为空，应该使用默认封面" do
      create(:no_cover_program).cover.must_equal Settings.default_cover
    end

    it "上线时间不应该为空" do
      build(:no_online_date_program).must_be :invalid?
    end
  end

  describe "节目预约" do
    before do
      @user = create(:user)
      @program = create(:program)
      @never_expired_program = create(:never_expired_program)
    end

    it "预约节目时，预约表数据应该增加 1 条" do
      origin_size = @user.appointments.size
      appointment = @user.appointments.build(:user_id => @user.id, 
        :program_id => @program.id, 
        :state => Appointment::STATE[:normal])
      appointment.save
      (@user.appointments.size - origin_size).must_equal 1
    end

    it "应该有获取有效预约总数的方法" do
      @program.respond_to?(:valid_total_appointments).must_equal true
      @program.valid_total_appointments.each do |appointment|
        appointment.state.must_equal Appointment::STATE[:normal]
      end
    end

    it "当预约变化时，总数应该做相应变化" do
      origin_size = @never_expired_program.valid_total_appointments.size
      appointment = @user.appointments.create(:user_id => @user.id, 
        :program_id => @never_expired_program.id,
        :state => Appointment::STATE[:normal])
      (@never_expired_program.valid_total_appointments.size - origin_size).must_equal 1
    end
  end

end
