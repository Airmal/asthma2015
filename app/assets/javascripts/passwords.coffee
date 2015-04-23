window.passwords_new = 
  init: () ->
    $("#user_email").bind 'blur', (event) =>
      @check_email()
    $("#user_password").bind 'blur', (event) =>
      @check_password()
    $("#user_password_confirmation").bind 'blur', (event) =>
      @check_password_confirmation()

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
    else
      $(".user_email p:first").html("");
      $(".user_email").removeClass("has-error")
      $('.user_email p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')

  # 检查密码
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
    
  # 检查新密码
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