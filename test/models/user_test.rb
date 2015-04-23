require "test_helper"

describe User, :type => :model do
  let(:user) { build(:user) }

  describe "新建用户时（用户注册时）" do
    it "用户名不应该为空" do
      user.username = ''
      user.must_be :invalid?
    end

    it "邮箱不应该为空" do
      user.email = ''
      user.must_be :invalid?
    end

    it "手机号码不应该为空" do
      user.mobile = ''
      user.must_be :invalid?
    end

    it "密码不应该为空" do
      user.password = ''
      user.must_be :invalid?
    end

    let(:duplicated_user) { build(:user) }
    it "用户名不应该重复注册" do
      user.save
      duplicated_user.username = user.username
      duplicated_user.must_be :invalid?
    end

    it "邮箱不应该重复注册" do
      user.save
      duplicated_user.email = user.email
      duplicated_user.must_be :invalid?
    end

    it "手机号码不应该重复注册" do
      user.save
      duplicated_user.mobile = user.mobile
      duplicated_user.must_be :invalid?
    end

    it "用户名字符数应该是4-16位" do
      invalid_usernames = ['abc', 'abcdefghijklmnopqrstuvwxyz']
      invalid_usernames.each do |un|
        user.username = un
        user.must_be :invalid?
      end
    end

    it "以下邮箱格式应该不符合标准" do
      invalid_emails = ['abc@abc', 'abc.com', 'abc@', 'abc@abc-abc']
      invalid_emails.each do |em|
        user.email = em
        user.must_be :invalid?
      end
    end

    it "密码字符数应该是8-20，且不应该全为数字" do
      invalid_passwords = ['123abc', '12345678', '1234567890abcdefghijk']
      invalid_passwords.each do |ps|
        user.password = ps
        user.must_be :invalid?
      end
    end
  end

  describe "忘记密码时" do
    it "用户应该验证手机短信后才能修改密码" do
      # 需要加入 smart_sms 短信组件
      flunk "Need Real Test"
    end
  end

  describe "用户积分" do
    let(:user2) { create(:user) }
    let(:login_action) { create(:login_action) }
    it "用户应该有累计积分的方法，且累计积分后用户积分表的数据应该增加 1 条" do
       user2.respond_to?(:earn_point).must_equal true
       origin_size = user2.user_points.size
       if user2.respond_to?(:earn_point)
          user2.earn_point(login_action.id)
          (user2.user_points.size - origin_size).must_equal 1
       end
    end

    let(:user3) { create(:user) }
    let(:login_action2) { create(:login_action) }
    it "用户应该可以查询总积分" do
      user2.respond_to?(:total_point).must_equal true
      if user2.respond_to?(:earn_point) && user2.respond_to?(:total_point)
        origal_point = user2.total_point || 0
        user2.earn_point(login_action2.id) if !login_action2.new_record?
        user2.total_point.must_equal origal_point + login_action2.point
      end
    end
  end
end
