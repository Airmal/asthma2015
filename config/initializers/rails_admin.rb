# require Rails.root.join('lib', 'rails_admin_publish.rb')
require 'rails_admin/publish'
require 'rails_admin/purchase'
require 'rails_admin/allNewPurchases'

RailsAdmin.config do |config|
  config.authorize_with :cancan
  config.authenticate_with do
    warden.authenticate! scope: :admin

    # # 非网站管理员
    # if authenticate_admin!.administrator_flg == '1'
    #   # 黑名单
    #   config.excluded_models = ["Program", "UserPoint", "Invitate", "Interactive", "Admin", "Appointment", "Courseware", "User", "UsersVsInteractive","Reply","Question" , "Comment", "UserAction"]  
   
    #   # config.actions do
    #   #   new do
    #   #     except ['Purchase']
    #   #   end
    #   # end
    # end
  end
  config.current_user_method(&:current_admin)
  #Set the application name
  config.main_app_name = ["云医Yunmed", "后台管理系统"]
  ### Popular gems integration
 
  # config.included_models = ["Program"] 白名单
  # config.navigation_static_label = "My Links"
  # config.navigation_static_links = {
  #  'Google' => 'https://www.google.com.sg/'
  # }

  module RailsAdmin
    class Publish < RailsAdmin::Config::Actions::Base    #Publish操作继承Base
      RailsAdmin::Config::Actions.register(self)      #RailsAdmin中注册demo操作
      register_instance_option :member do             #设置其action scope为member
        true
      end
    end
    
    # class AllNewPurchases < RailsAdmin::Config::Actions::Base    #Publish操作继承Base
    #   RailsAdmin::Config::Actions.register(self)      #RailsAdmin中注册demo操作
    #   register_instance_option :collection do             #设置其action scope为member
    #     true
    #   end
    # end
  end
  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  # config.model 'User' do
  #   navigation_icon 'icon-user'
  # end
  config.model 'Purchase' do
    list do
      configure :id do
        hide
      end
    end
  end
  config.model 'Program' do
    list do
      configure :id do
        hide
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    ## With an audit adapter, you can add:
    history_index
    history_show

    all_new_purchases do      # subclass Base. Accessible at /admin/<model_name>/<id>/my_member_action
      controller
      i18n_key :submit_purchase
      only 'Purchase'
    end
    # Set the custom action here
    publish do
      only 'Program'
    end

    member :purchase do
      only 'Program'
      i18n_key :post_purchase
    end
  end

  # navigation set user order first (Lower values will bubble items to the top, higher values will move them to the bottom)
  config.model 'User' do
    weight -1
  end
end
