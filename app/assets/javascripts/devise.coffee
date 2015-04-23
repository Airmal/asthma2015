window.devise_signup = 
  wait: 60 # 短信倒计时秒数
  init: () ->
    $("#user_username").bind 'blur', (event) =>
      @check_username()
    $("#user_email").bind 'blur', (event) =>
      @check_email()
    $("#user_password").bind 'blur', (event) =>
      @check_password()
    $("#user_password_confirmation").bind 'blur', (event) =>
      @check_password_confirmation()
    $("#user_mobile").bind 'blur', (event) =>
      @check_mobile()
    $("#sms_code").bind 'blur', (event) =>
      @check_smscode()
    $("#send_sms_btn").bind 'click', (event) =>
      @send_sms()
    $("#user_invitate_cd").bind 'blur', (event) =>
      @check_invitatecode()

  # 检查用户名
  check_username: () ->
      username = $("#user_username").val();
      $(".user_username span:first").html("");
      if !username? or username == ""
        $(".user_username").addClass("has-error");
        $(".user_username p:first").html("请输入您的姓名。");
      else if username.length < 2 or username.length > 16
        $(".user_username").addClass("has-error");
        $(".user_username p:first").html("请确认您的姓名长度。");
      # else if !username.match /^[a-zA-Z][a-zA-Z0-9_]{3,16}$/
      #   $(".user_username").addClass("has-error");
      #   $(".user_username p:first").html("该用户名不符合要求。");
      # else if @validate_duplicate(username)
      #   $(".user_username").addClass("has-error");
      #   $(".user_username p:first").html("该用户名已被注册。");
      else 
        $(".user_username p:first").html("");
        $(".user_username").removeClass("has-error")
        $('.user_username p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
  
  # 检查邮箱
  check_email: () ->
    email = $('#user_email').val();
    $(".user_email span:first").html('');
    if !email? or email == ""
      $(".user_email").addClass("has-error");
      $(".user_email p:first").html("请填写最常用的邮箱。");
    else if !email.match /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/
      $(".user_email").addClass("has-error");
      $(".user_email p:first").html("邮箱格式不正确。");
    else if @validate_duplicate(email)
      $(".user_email").addClass("has-error");
      $(".user_email p:first").html("该邮箱已被注册。");
    else
      $(".user_email p:first").html("");
      $(".user_email").removeClass("has-error")
      $('.user_email p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
    
  check_password: () ->
    password = $('#user_password').val();
    $('.user_password span:first').html('');
    if !password? or password == ""
      $(".user_password").addClass("has-error");
      $(".user_password p:first").html("请输入8位以上的字符。");
    else if password? and password.length < 8
      $(".user_password").addClass("has-error");
      $(".user_password p:first").html("请输入8位以上的字符。");
    else
      $(".user_password p:first").html("");
      $(".user_password").removeClass("has-error")
      $('.user_password p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
    
  check_password_confirmation: () ->
    password = $('#user_password').val();
    password_confirmation = $('#user_password_confirmation').val();
    $('.user_password_confirmation span:first').html("");
    if !password_confirmation? or password_confirmation == ""
      $(".user_password_confirmation").addClass("has-error");
      $(".user_password_confirmation p:first").html("请确认密码是否一致。");
    else if password != password_confirmation
      $(".user_password_confirmation").addClass("has-error");
      $(".user_password_confirmation p:first").html("两次密码输入不一致。");
    else
      $(".user_password_confirmation p:first").html("");
      $(".user_password_confirmation").removeClass("has-error")
      $('.user_password_confirmation p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
  
  # 检查手机号
  check_mobile: () ->
    mobile = $('#user_mobile').val();
    $('.user_mobile span:first').html('');
    if !mobile? or mobile == ""
      $(".user_mobile").addClass("has-error");
      $(".user_mobile p:first").html("请输入有效的11位手机号码。");
    else if !mobile.match /^((\(\d{2,3}\))|(\d{3}\-))?1[3,8,5]{1}\d{9}$/
      $(".user_mobile").addClass("has-error");
      $(".user_mobile p:first").html("输入的手机号码是无效的，请检查。");
    else if @validate_duplicate(mobile)
      $(".user_mobile").addClass("has-error");
      $(".user_mobile p:first").html("该手机号码已被注册。");
    else
      $(".user_mobile p:first").html("");
      $(".user_mobile").removeClass("has-error")
      $('.user_mobile p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
  
  # 检查短信验证码
  check_smscode: () ->
    mobile = $('#user_mobile').val();
    sms_code = $('#sms_code').val();
    if mobile.length != 11
      $('.user_mobile').addClass('has-error')
      $('.user_mobile p.help-block').html('请输入有效的11位手机号码。')
      # 光标焦点
      # $('#user_mobile').focus();
    else if sms_code.length != 4
      $('.user_sms_code').addClass('has-error')
      $('.user_sms_code p.help-block').html('验证码错误！')
    else
      $.ajax
        url: '/check_sms'
        type: 'POST'
        data: 
          mobile: mobile
          sms_code: sms_code
        success: (data, status, response) =>
          if data['result'] == "success"
            $(".user_sms_code").removeClass("has-error")
            $('.user_sms_code p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>');
          else
            $('.user_sms_code').addClass('has-error');
            $('.user_sms_code p.help-block').html('验证码错误！');

  # 检查邀请码
  check_invitatecode: () ->
    invitatecode = $('#user_invitate_cd').val()
    if invitatecode.length == 0
      $('.user_invitate_cd').removeClass('has-error')
      return
    if invitatecode.length != 8
      $('.user_invitate_cd').addClass('has-error')
      $('.user_invitate_cd p.help-block').html('请输入8位长度邀请码！')
    else 
      $.ajax
        url: '/check_invitatecode'
        type: 'POST'
        data: 
          invitatecode: invitatecode
        success: (data,status) =>
          if data['result'] == "success"
            $(".user_invitate_cd").removeClass("has-error")
            $('.user_invitate_cd p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')
          else
            $('.user_invitate_cd').addClass('has-error')
            $('.user_invitate_cd p.help-block').html('邀请码错误！')
  
  # 发送短信
  send_sms: () ->
    mobile = $('#user_mobile').val()
    @check_mobile()
    $.ajax
      url: '/send_sms'
      type: 'POST'
      data:
        mobile: mobile
      success: () ->

    @sms_countdown($('#send_sms_btn'))

  # 短信倒计时 
  sms_countdown: (t) ->
    if @wait == 0
      t.attr('disabled', false);
      t.text('获取验证码');
      @wait = 60;
    else
      t.attr('disabled', true);
      t.text('重新发送（' + @wait + "）秒")
      @wait--
      `setTimeout(function(){devise_signup.sms_countdown(t)}, 1000)`

  # 验证账户是否重复
  validate_duplicate: (login_id) ->
    invalid = true
    $.ajax
      url: '/check_login'
      type: 'POST'
      async: false
      data:
        login: login_id
      success: (data) =>
        if data['result'] == "success"
          invalid = false
    invalid

  validateForm: () ->
    $(".has-error").length is 0 and devise_signup.checkInpTxt() 

  checkInpTxt: () ->
    formControls = $(".form-control")
    return false for strs in formControls when strs.value is "" and strs.name != "user[invitate_cd]"