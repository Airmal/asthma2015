class ProgramsCtrlController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:current_page] = $global_redis.get("current_page").to_i || 0
  end

  def prev_page
    controller_store[:current_page] -= 1 if controller_store[:current_page] > 0
    $global_redis.set("current_page", controller_store[:current_page])
    data = { current_page: controller_store[:current_page] }
    broadcast_message :go_ahead, data, namespace: 'program'
    trigger_success data
  end

  def next_page
    # controller_store[:current_page] += 1 if controller_store[:current_page] < ($global_redis.get("program_#{message[:program_id]}_total_page_number").to_i || 100)
    if controller_store[:current_page] < 100 && controller_store[:current_page]+1 < $global_redis.get("program_1_total_page_number").to_i
      controller_store[:current_page] += 1 
    end
    $global_redis.set("current_page", controller_store[:current_page])
    $global_redis.sadd("live_program_#{message[:program_id]}", message[:time])
    data = { current_page: controller_store[:current_page] }
    broadcast_message :go_ahead, data, namespace: 'program'
    trigger_success data
  end
end
