require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  class Purchase < RailsAdmin::Config::Actions::Base    #Demo操作继承Base
    RailsAdmin::Config::Actions.register(self)      #RailsAdmin中注册demo操作

    register_instance_option :member do             #设置其action scope为member
      true
    end

    register_instance_option :http_methods do
      [:get, :post]
    end

    # register_instance_option :controller do
    #   Proc.new do
    #      @value = 'request is get'
    #     if request.get? # EDIT
    #     elsif request.put? # UPDATE
    #    	  sadf
    #       @value = 'request is put'
    #     elsif request.post? # 
    #    	  sadf
    #       @value = 'request is post'
    #   	end
    #   end
    # end
  end
end