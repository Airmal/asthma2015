window.pages_index =
  init: () ->
    if !$('#sTime')[0]?
      return
    sTime = $('#sTime')[0].innerHTML.replace(/\./g, "/")
    $('#getting-started').countdown sTime, (event) ->
      if !$('#temple')[0]?
        return
      if event.offset['seconds'] == 0 and event.offset['minutes'] == 0 and event.offset['hours'] == 0 and event.offset['totalDays'] == 0
        $('#temple')[0].innerHTML = ""
        $(this).html("直播已开始")
      else
        $('#temple')[0].innerHTML = "倒计时："
        $(this).html(event.strftime('%-D天%-H小时%-M分钟%-S秒'))

  booking: (id, title, speaker, start_time, pid, userid, bid) -> 
  
    if $("#"+id)[0].innerHTML.trim() == '预约报名'
      flg = '1'
    else
      flg = '0'

    para = 
      title: title,
      speaker: speaker,
      start_time: start_time,
      bid: $("#"+bid).val(),
      pid: pid,
      user_id: userid,
      booked: flg

    $.ajax
      url: '/bookings/edit',
      type: 'POST',
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(para),
      success: (data) =>
        re_bid = data['bid']
        $('#'+bid).val(re_bid)
        c_name = $("#"+id)[0].className
        if flg == '1'
          $("#"+id)[0].innerHTML = '已报名'
          $("#"+id)[0].className = c_name.replace("btn-danger", "btn-none")
        else
          $("#"+id)[0].innerHTML = '预约报名'
          $("#"+id)[0].className = c_name.replace("btn-none", "btn-danger")
        
  gologin: () ->
    alert "请先登录"
    window.location.href = "/users/sign_in"