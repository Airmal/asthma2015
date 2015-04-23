require "test_helper"

describe ProgramsController, :type => :controller do
  let(:program) { create(:program) }

  describe "节目动态路由" do
    it "访问节目索引页后，当前页面应该是节目索引页" do
      visit programs_path
      current_path.must_equal programs_path
      page.must_have_selector('div#ym-41f383d5')
    end

    it "应该有节目标题" do
      program2 = FactoryGirl.create(:program)
      visit programs_path
      page.must_have_content(program2.title)
    end

    it "访问节目详情页，当前页面应该是节目详情页" do
      visit program_path(program)
      current_path.must_equal program_path(program)
      page.must_have_selector('div#ym-5d6ac096')
    end

    it "访问节目详情页，应该有节目标题" do
      visit program_path(program)
      page.must_have_content(program.title)
    end

    it "访问添加节目页后，当前页面应该是添加节目页" do
      # 尚未登录，访问页面
      visit new_program_path
      # 应该跳转至登录页面
      page.must_have_selector 'h2', :text => 'Log in'
      # 手动登录并重试
      sign_in!
      visit new_program_path
      current_path.must_equal new_program_path
      # div-id ???
      page.must_have_selector('div#ym-41f383d5')
    end

  end

  describe "节目页面跳转相关" do
    it "对于能够被预约的节目，应该具有以下流程", js: true do
      never_expired_program = FactoryGirl.create(:never_expired_program)
      # 尚未登录，访问页面
      visit programs_path
      # 对某个项目点击预约报名
      click_link "appointment-program-#{never_expired_program.id}", :text => '预约报名'
      # ajax 提交
      wait_for_ajax
      # 应该跳转至登录页面
      page.must_have_selector 'h2', :text => 'Log in'
      # 手动登录并重试
      sign_in!
      click_link "appointment-program-#{never_expired_program.id}", :text => '预约报名'
      wait_for_ajax
      # 应该显示预约成功
      page.must_have_content('预约成功')
      # 再次访问页面
      visit programs_path
      # 应该显示已预约字样
      page.must_have_content('已预约')
      # 还应该有取消预约的链接
      page.must_have_link('取消预约')
    end

    it "对于不能够被预约的节目，应该具有以下反馈", js: true do
      expired_program = FactoryGirl.create(:expired_program)
      sign_in!
      visit programs_path
      click_link "appointment-program-#{expired_program.id}", :text => '预约报名'
      wait_for_ajax
      page.wont_have_content('预约成功')
    end

    # it "如果未登录，点击预约报名应该跳转至登录页面", js: true do
    #   program3 = FactoryGirl.create(:program)
    #   visit programs_path
    #   click_link "appointment-program-#{program3.id}", :text => '预约报名'
    #   wait_for_ajax
    #   page.must_have_selector 'h2', :text => 'Log in'
    # end

    it "提交一条节目短评", js:true do
      # 尚未登录，访问页面
      visit programs_path(program)
      # 生成一条评论
      create_comment
      # 提交评论
      click_link "post_comment", :text => '提 交'
      # ajax 提交
      wait_for_ajax
      # 应该跳转至登录页面
      page.must_have_selector 'h2', :text => 'Log in'
      # 手动登录并重试
      sign_in!
      click_link "post_comment", :text => '提 交'
      wait_for_ajax
      # TODO 验证
    end

    it "提交一条提问", js:true do
      # 尚未登录，访问页面
      visit programs_path(program)
      # 生成一条提问
      create_question
      # 提交提问
      click_link "post_question", :text => '提 交'
      # ajax 提交
      wait_for_ajax
      # 应该跳转至登录页面
      page.must_have_selector 'h2', :text => 'Log in'
      # 手动登录并重试
      sign_in!
      click_link "post_question", :text => '提 交'
      wait_for_ajax
      # 应该显示刚才的提问
      page.must_have_content('这是提问标题')
      # 生成一条回复
      create_reply('1')
      # 提交回复
      click_link "post_reply", :text => '提 交'
      # 应该显示提问的回复
      page.must_have_content('这是提问的回答1')
      # 再发布一条回复
      create_reply('2')
      click_link "post_reply", :text => '提 交'
      page.must_have_content('这是提问的回答2')
    end

    it "添加一条新节目" do
      # 手动登录
      sign_in!
      # 访问添加节目页面
      visit new_courseware_path
      # 添加节目
      program3 = FactoryGirl.create(:program)
      click_link "submit", :text => '提交'
      # 跳转到添加课件画面
      current_path.must_equal new_courseware_path
    end
  end
end
