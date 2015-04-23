# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Program
  constructor: ->
  ajax_post_appoint: (program_id, url) ->
    $.ajax
      url: url
      type: 'POST'
      data: 
        id: program_id
      success: (data, status, response) =>
        @appointment_success(program_id)
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'

  # 预约成功
  appointment_success: (program_id) ->
    $('#appointment-program-' + program_id + '-appoint').prev().html("<p class='appoint-success'> <i class='fa fa-check-circle'></i> 预约成功！</p>")
    $('#appointment-program-' + program_id + '-appoint').css('display', "none");

  ajax_post_unappoint: (program_id, url) ->
    $.ajax
      url: url
      type: 'POST'
      data:
        id: program_id
      success: (data, status, response) =>
        @unappointment_success(program_id)
      error: (xml, status, error) =>
        @deal_with_exception(xml)
      dataType: 'json'

  unappointment_success: (program_id) ->
    $('#appointment-program-' + program_id + '-unappoint').prev().html("<p class='appoint-success'> <i class='fa fa-check-circle'></i> 取消成功！</p>")
    $('#appointment-program-' + program_id + '-unappoint').css('display', "none");
  # 未登录跳转
  redirect_to_login: () ->
    window.location = '/users/sign_in'

  # 数据错误处理
  deal_with_exception: (xml) ->
    alert(xml.responseJSON.result);

window.programs_index = new Program

window.program_show = 
  images: ''
  locImgIdx: 0
  timelength: 0
  times: {}
  init: () ->
    owl = $(".program-stage").owlCarousel({
      slideSpeed : 300,
      paginationSpeed : 400,
      singleItem:true,
      autoHeight: true,
      pagination: false,
      mouseDrag: false,
      touchDrag: false,
      transitionStyle: "fade"
    });

    $('.show-next').bind 'click', () -> 
      owl.trigger('owl.next');
      if $('#replay_video').length > 0
        videojs('replay_video').play();
      $('#interactives_list').css('display','block')

    $('.show-prev').bind 'click', () -> 
      owl.trigger('owl.prev');

    if !$('#sTime')[0]?
      return
    sTime = $('#sTime').val().replace(/\./g, "/")
    $('#temple').countdown sTime, (event) ->
      if !$('#temple')[0]?
        return
      if event.offset['seconds'] == 0 and event.offset['minutes'] == 0 and event.offset['hours'] == 0 and event.offset['totalDays'] == 0
        $('#temple')[0].innerHTML = "直播已开始"
        $('.btn-post-appoint').css('display','none')
      else
        $('#temple')[0].innerHTML = "直播倒计时：" + event.strftime('%D天%H小时%M分钟%S秒')
        $('#get_into_live').css('display','none')

    $('#sticky-spacer').sticky({
      topSpacing: 0,
      getWidthFrom:'#main-content'
    });
    $('#sticky-spacer a').bind 'click', (event) ->
      $(this).tab('show')
    $("#commentModel").bind 'show.bs.modal', (event) =>
      program_id = $("#program_id").val()
      $.ajax
        url: '/my_comment'
        type: 'get'
        data:
          program_id: program_id
        success: (data, status, response) =>
          # $('#comment_rank').val(data['rank'])
          $('#comment_content').val(data['content'])
          rank_index = data['rank'] - 1
          for index in [0..rank_index]
            jquery_rank = $("#star_"+index)
            jquery_rank.addClass("get")
        error: (xml, status, error) =>
          switch xml.status
            when 401
              @redirect_to_login()
            when 422
              @deal_with_exception(xml)
        dataType: 'json'
    $('.my-comment-star').hover (event) -> 
      it = $(this)
      prev_all = it.prevAll()
      next_all = it.nextAll()
      it.addClass("get")
      for prev in prev_all
        jquery_prev = $("#"+prev.id)
        jquery_prev.addClass("get")
      for next in next_all
        jquery_next = $("#"+next.id)
        jquery_next.removeClass("get")
    @images_onload()

  auto_play_ppt: (time_line) ->
    t_index = 1
    for time in time_line
      @times[time] = {img_index: t_index}
      t_index++

    $('#replay_video').bind 'timeupdate', () ->
      int_currentTime = parseInt(this.currentTime)

      if program_show.times[int_currentTime]?
        program_show.locImgIdx = program_show.times[int_currentTime].img_index
        $('#showPPT').attr("src", program_show.images[program_show.locImgIdx])
        program_show.select_image()
      else
        index = 0
        for key, value of program_show.times
          if index == 0 && 0 < int_currentTime && int_currentTime < key
            program_show.locImgIdx = 0
            $('#showPPT').attr("src", program_show.images[program_show.locImgIdx])
            program_show.select_image()
            break
          else if int_currentTime > key
            program_show.locImgIdx = value.img_index
            $('#showPPT').attr("src", program_show.images[program_show.locImgIdx])
            program_show.select_image()
          index++

  chgImg: (act) ->
    if @images == null || @images.length <= 0
      return
    #上一页
    if act == '0'
      if --@locImgIdx <= 0
        @locImgIdx = 0
    else
      #下一页
      if ++@locImgIdx >= @images.length - 1
        @locImgIdx = @images.length - 1
    $('#showPPT').attr("src", @images[@locImgIdx])
    @select_image()

  images_onload: () ->
    @locImgIdx = 0
    @images = eval($('#live_images').val());
    if @images != null && @images.length > 0
      for image in @images
        new_image = new Image();
        new_image.src = image;

      $('#showPPT').attr("src", @images[0]);
      $('#page_li_1').attr("src", @images[0])
      if @images[1] != undefined
        $('#page_li_2').attr("src", @images[1])
      if @images[2] != undefined
        $('#page_li_3').attr("src", @images[2])

      if @images.length <= 1 && $(".ppt-a").length > 0
        $(".ppt-a").css('height', '100%')
    else
      $('#ppt-b').css("display", 'none')


  display_clicked_page: (page_id) ->
    @locImgIdx = @images.indexOf($('#'+page_id).attr("src"))
    $('#showPPT').attr("src", $('#'+page_id).attr("src"))
    @select_image()

  select_image: () ->
    $('#li_1').removeClass('select-image')
    $('#li_2').removeClass('select-image')
    $('#li_3').removeClass('select-image')
    if @locImgIdx == 0
      $('#li_1').addClass('select-image')

    else if @locImgIdx == @images.length-1
      $('#li_3').addClass('select-image')

    else
      $('#li_2').addClass('select-image')
      $('#page_li_2').attr("src", @images[@locImgIdx])
      if @images[@locImgIdx-1] != undefined
        $('#page_li_1').attr("src", @images[@locImgIdx-1])
      
      if @images[@locImgIdx+1] != undefined
        $('#li_a_3').css("visibility", "visible")
        $('#page_li_3').attr("src", @images[@locImgIdx+1])
      else
        $('#li_a_3').css("visibility", "hidden")

  ajax_post_interactive: (interactive_id) ->
    selections = new Array()
    for selection in $("input[name='selection']")
      if selection.checked == true
        selections.push(selection.value)

    $.ajax
      url: 'submit_interactive'
      type: 'POST'
      data: 
        interactive_id: interactive_id
        selections: selections
      dataType: 'json'
      success: (data, status, response) =>
        alert("提交成功，谢谢！")
        $('#interactives_list').css('display','none')
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
    
  ajax_post_appoint: (program_id, url, exists_invitate_cd) ->
    invitate_cd = exists_invitate_cd
    if invitate_cd == undefined
      invitate_cd = $('#invitate_cd').val()

    $.ajax
      url: url
      type: 'POST'
      data: 
        id: program_id
        invitate_cd: invitate_cd
      success: (data, status, response) =>
        if data['failed'] != undefined
          alert(data['failed'])
        else
          @appointment_success(program_id)
        if exists_invitate_cd == undefined
          $('#appointModel').modal('toggle')
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'
  
  # 预约成功
  appointment_success: (program_id) ->
    $('#appointment-program-' + program_id + '-appoint').css('display', "none");
    $('#appointment-program-' + program_id + '-appoint').after("<span class='appoint-success'> <i class='fa fa-check-circle'></i> 预约成功！</span>")

  ajax_post_unappoint: (program_id, url) ->
    $.ajax
      url: url
      type: 'POST'
      data: 
        id: program_id
      success: (data, status, response) =>
        @unappointment_success(program_id)
      error: (xml, status, error) =>
        switch xml.status
          when 401
            @redirect_to_login()
          when 422
            @deal_with_exception(xml)
      dataType: 'json'

  unappointment_success: (program_id) ->
    $('#appointment-program-' + program_id + '-unappoint').css('display', "none");
    $("#appointment-program-1-unappoint").prev(".appoint-success").html("<i class='fa fa-check-circle'></i> 取消成功！")

  # 数据错误处理
  deal_with_exception: (xml) ->
    alert(xml.responseJSON.result);

  # 未登录跳转
  redirect_to_login: () ->
    window.location = '/users/sign_in'

  # 提问拼接
  append_question: (question) ->
    replies_num = question['replies']
    replies_num = '' if replies_num < 1
    $("#question_ul").append('<li id="' + question['id'] + '"><div class="content">' + '<h3 class="question-title"><a href="/questions/' + question['id'] + '">' + question['title'] + '</a><span class="replies-num">' + replies_num + '</span></h3><span class="question-user">' + question['username'] + '</span><span class="question-time">' + question['updated_at'] + '</span></div></li>');

  # 短评拼接
  append_comment: (comment) ->
    rank = ''
    num = comment['rank']
    for i in [1..num]
      rank += '<i class="glyphicon glyphicon-star get"></i>'
    for j in [num+1..5] by 1
      rank += '<i class="glyphicon glyphicon-star"></i>'

    $("#comment_ul").append('<li id="' + comment['id'] + '"><div class="rank">' + '<span class="username">' + comment['username'] + '</span><span class="star">'+rank+'</span></div><div class="content">' + comment['content'] + '</div><div class="create-at">' + comment['updated_at'] + '</div></li>');
  
  # 提交短评
  ajax_post_comment: (program_id, url) ->
    rank = $(".glyphicon.glyphicon-star.my-comment-star.get").length
    content = $("#comment_content").val()

    if content.trim() == ""
      alert("请输入短评内容")
    else
      $.ajax
        url: url
        type: 'POST'
        data: 
          program_id: program_id
          rank: rank
          content: content
        success: (data, status, response) =>
            $('#comment_ul').html('')
            @append_comment comment for comment in data['data']
            $('#commentModel').modal('toggle')
        error: (xml, status, error) =>
          switch xml.status
            when 401
              @redirect_to_login()
            when 422
              @deal_with_exception(xml)
        dataType: 'json'

  # 提交问题
  ajax_post_question: (program_id, url) ->
    title = $("#question_title").val()
    content = $("#question_content").val()

    if title.trim() == ""
      alert("标题不能为空")
    else if content.trim() == ""
      alert("请输入提问内容")
    else
      $.ajax
        url: url
        type: 'POST'
        data: 
          program_id: program_id
          title: title
          content: content
        success: (data, status, response) =>
            $('#question_ul').html('')
            @append_question question for question in data['data']
            $('#questionModel').modal('toggle')
            $('#question_title').val('')
            $('#question_content').val('')
        error: (xml, status, error) =>
          switch xml.status
            when 401
              @redirect_to_login()
            when 422
              @deal_with_exception(xml)
        dataType: 'json'
#   detail_show: () ->
#     $('video').mediaelementplayer({
#       alwaysShowControls: false,
#       features: ['playpause','fullscreen','current','duration']
#     })
#     locImgs = locImgs.replace(/&quot;/g,"").replace("[","").replace("]","").split(",")
#     maxLength = locImgs.length
#     currIdx = 0
#     if locImgs != null and locImgs.length > 0
#       img for img in [0..locImgs.length]
#       # TODO
#       document.getElementById('showPPT').src = locImgs[0];
#       if locImgs.length <= 1
#         $(".ppt-a")[0].style.height = "100%";
#     if window.innerWidth < 1024
#       document.getElementById("mep_0").style.width = '480px';
#       document.getElementById("mep_0").style.height = '320px';

#   chgImg: (act) ->
#     idx = 0
#     if locImgs == null or locImgs.length <= 0
#       return
#     #上一页
#     if act == '0'
#       if --locImgIdx <= 0
#         locImgIdx = 0
#     else
#       #下一页
#       if ++locImgIdx >= locImgs.length - 1
#         locImgIdx = locImgs.length - 1
#     document.getElementById('showPPT').src = locImgs[locImgIdx]

#   chgModel: () ->
#     check = document.getElementById('chgPage')
#     if check.checked
#       document.getElementById('l1').innerHTML = '自动模式'
#       document.getElementById('next').disabled = true
#       document.getElementById('last').disabled = true
#     else
#       document.getElementById('l1').innerHTML = '手动模式'
#       document.getElementById('next').disabled = false
#       document.getElementById('last').disabled = false

#   checkLen: (it) ->
#     maxChars = it.maxLength
#     if it.value.length <= maxChars
#       document.getElementById('spnright').innerHTML = it.value.length
  
#   getQuestions: () -> 
#     $('#quest')[0].className = 'cura'
#     $('#comment')[0].className = 'curb'
#     $('#qContent')[0].style.display = 'block'
#     $('#cContent')[0].style.display = 'none'
#     return false
   
#   getComments: () ->
#     $('#comment')[0].className = 'cura'
#     $('#quest')[0].className = 'curb'
#     $('#cContent')[0].style.display = 'block'
#     $('#qContent')[0].style.display = 'none'
#     return false

#   upComment: () ->
#     comment = {
#       artid: $("#comment_artid").val(),
#       comment: $("#comtxt").val(),
#       email: $("#comment_email").val(),
#       username: $("#comment_username").val()
#     }

#     $.ajax
#       url: '/comments'
#       type: 'POST'
#       dataType: "JSON"
#       contentType: "application/json"
#       data: JSON.stringify(comment)
#       success: (data) =>
#         document.getElementById('comments').innerHTML = ""
#         comments = data['data']
#         document.getElementById('allCommentNum').innerHTML = "共" + comments.length.toString() + "条留言"
#         comments for j in [0..comments.length]

#   upQuestion: () ->
#     question = {
#       artid: $("#comment_artid").val(),
#       question: $("#quetxt").val(),
#       email: $("#question_email").val(),
#       username: $("#question_username").val()
#     }

#     $.ajax
#       url: '/questions'
#       type: 'POST'
#       dataType: "JSON"
#       contentType: "application/json"
#       data: JSON.stringify(question)
#       success: (data) =>
#         document.getElementById('questions').innerHTML = ""
#         questions = data['data']
#         document.getElementById('allQuestNum').innerHTML = "共" + questions.length.toString() + "条提问"
#         questions for j in [0..questions.length]
