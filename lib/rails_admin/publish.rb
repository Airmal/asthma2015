require 'rails_admin/config/actions/base'

module RailsAdmin
  class Publish < RailsAdmin::Config::Actions::Base    #Demo操作继承Base
    RailsAdmin::Config::Actions.register(self)      #RailsAdmin中注册demo操作

    register_instance_option :member do             #设置其action scope为member
      true
    end

  end
end
 