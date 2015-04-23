ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
# require 'minitest/autorun'
require "minitest/rails"
require "minitest/rails/capybara"
# require "minitest/reporters"
require 'minitest-metadata'
require 'capybara-webkit'
require 'database_cleaner'

# Minitest::Reporters.use!(
#   Minitest::Reporters::ProgressReporter.new,
#   ENV,
#   Minitest.backtrace_filter
# )

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include MiniTest::Metadata
  include Capybara::DSL
  include Capybara::Assertions
  Capybara.javascript_driver = :webkit
  ActiveRecord::Migration.check_pending!
  self.use_transactional_fixtures = false

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      active = page.evaluate_script('jQuery.active')
      until active == 0
        active = page.evaluate_script('jQuery.active')
      end
    end
  end

  def setup
    if metadata[:js]
      Capybara.current_driver = :webkit
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_session!
    Capybara.use_default_driver
  end

  # 手动登录
  def sign_in!
    User.first || FactoryGirl.create(:user)
    visit new_user_session_path
    within("form") do
      fill_in 'Email', :with => 'mail1@yunmed.net'
      fill_in 'Password', :with => 'p@ssw0rd'
    end
    click_button 'Log in'
  end

  # 生成一条评论
  def create_comment
    within("div_post_comment") do
      fill_in 'comment_rank', :with => 4
      fill_in 'comment_content', :with => '这是七个字的短评'
    end
  end

  # 生成一条提问
  def create_question
    within("div_post_question") do
      fill_in 'question_title', :with => '这是提问标题'
      fill_in 'question_content', :with => '这是提问的内容'
    end
  end

  # 生成一条回复
  def create_question(index)
    within("div_post_reply") do
      fill_in 'reply_content', :with => '这是提问的回答'+index
    end
  end

  # 添加一条节目
  def create_program
    within("div_new_program") do
      fill_in 'program_public_no', :with => 'p_0001'
      fill_in 'program_title', :with => '节目标题'
      fill_in 'program_preview', :with => '节目预告'
      # fill_in 'program_cover', :with => '这是提问的回答'  #image
      attach_file('program_cover', '/Users/xielei/Downloads/p-01.jpg')
      fill_in 'program_intro', :with => '节目简介'
      fill_in 'program_online_date', :with => '2015/03/28 09:00:00'
      fill_in 'program_offline_date', :with => '2015/03/28 10:00:00'
      fill_in 'program_live_or_replay', :with => Program::TYPE[:live]
      fill_in 'program_categories', :with => '血液科'
      fill_in 'program_speakers', :with => '王鹏主任'
    end
  end



end
