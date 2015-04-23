source 'https://ruby.taobao.org'
ruby '2.1.1'

# => 基础必要的
gem 'rails', '4.2.0'
gem 'mysql2' # 使用 MySQL
gem 'sass-rails', '~> 5.0' # 使用 SCSS
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails' # 使用 JQuery
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# => 开发测试必要的
group :development, :test do
  gem 'byebug' # 在代码的任何地方调用 byebug 来停止执行并获得一个调试控制台
  gem 'web-console', '~> 2.0'
  gem 'spring'

  # 数据表注释
  gem 'migration_comments', '~> 0.3.2'
  gem 'database_cleaner', '~> 1.4.1'

  # Minitest
  gem 'minitest-rails', '~> 2.1.1'
  gem 'minitest-rails-capybara', '~> 2.1.0'
  gem 'minitest-reporters', '1.0.11'
  gem 'minitest-around', '~> 0.3.1'
  gem 'minitest-metadata', :require => false

  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'capybara-webkit', :git=> 'git://github.com/thoughtbot/capybara-webkit.git'

end

# => 生产必要的
group :production do
  gem 'unicorn', '~> 4.8.3'
end

# => 部署必要的
gem 'mina', '~> 0.3.1'

# => 其他常用组件
# ============================================================
gem 'devise', '~> 3.4.1' # 用户系统
gem 'cancancan', '~> 1.10' # permission
gem 'rails_admin', '~> 0.6.7'
gem 'settingslogic', '~> 2.0.8' # YAML 配置信息
gem 'high_voltage', '~> 2.2.1'
gem 'owlcarousel-rails'
gem 'smart_sms' # 集成云片网络的短信发送服务
gem 'simple_form', :git => 'https://github.com/plataformatec/simple_form.git', :branch => 'master' # 表单
gem 'railsstrap', '~> 3.3.2'
gem 'kaminari', '~> 0.16.3' # 分页组件
gem 'websocket-rails'
gem 'redis', '~> 3.2.1'
gem 'paperclip', '~> 4.2' # 上传组件
gem 'rmagick', '2.13.2', require: false # pdf->jpg 

