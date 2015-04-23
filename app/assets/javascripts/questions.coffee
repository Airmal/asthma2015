# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.questions_index =
  ajax_post_reply: (question_id, url) ->
    content = $('#reply_content').val()
    if content.trim() == ""
      alert("回复内容不能为空")
    else
      @deal_with_post_reply(question_id, url, content)


  ajax_post_best_reply: (reply_id, url) ->
    content = $('#reply_content').val()
    $.ajax
      url: url
      type: 'POST'
      data: 
        reply_id: reply_id
      success: (data, status, response) =>
        window.location.reload()
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'

  # 提交回复
  deal_with_post_reply: (question_id, url, content) ->
    $('#reply_post').attr('disabled',true)
    $.ajax
      url: url
      type: 'POST'
      data: 
        content: content
        question_id: question_id
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