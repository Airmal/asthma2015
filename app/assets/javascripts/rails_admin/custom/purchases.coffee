# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.purchase_create =

  # 请购邀请码
  ajax_post_purchase: (program_id) ->
    num_purchase = $('#num_purchase').val().trim()
    if num_purchase == ""
      return
      
    $('#purchase_submit').attr('disabled',true)
    $.ajax
      url: '/purchase/create'
      type: 'POST'
      data: 
        num_purchase: num_purchase
        program_id: program_id
      success: (data, status, response) =>
        window.location.reload()
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'

  # 审核通过请购
  ajax_post_commit_purchase: (purchase_id) ->
      
    $('#purchase_submit').attr('disabled',true)
    $.ajax
      url: '/purchase/commit_purchase'
      type: 'POST'
      data: 
        purchase_id: purchase_id
      success: (data, status, response) =>
        window.location.reload()
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'

  # 数据错误处理
  deal_with_exception: (xml) ->
    alert(xml.responseText)

  # 未登录跳转
  redirect_to_login: () ->
    window.location = '/users/sign_in'