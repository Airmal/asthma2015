require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  class AllNewPurchases < RailsAdmin::Config::Actions::Base    #Demo操作继承Base
    RailsAdmin::Config::Actions.register(self)      #RailsAdmin中注册demo操作

    register_instance_option :collection do             #设置其action scope为collection
      true
    end

    register_instance_option :http_methods do
      [:get, :post]
    end

    register_instance_option :controller do
      Proc.new do
        if request.get? # EDIT
          @purchases = @abstract_model.model.where(:purchase_flg => @abstract_model.model::STATE[:init]).order('created_at asc')
      	end
      end
    end
  end
end