# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.xcuser = 
  init: () ->
    $("#xcuser_email").bind 'blur', (event) =>
      @check_email()
    $("#xcuser_phone").bind 'blur', (event) =>
      @check_mobile()

  # 检查邮箱
  check_email: () ->
    email = $('#xcuser_email').val();
    $(".xcuser_email span:first").html('');
    if !email? or email == ""
      $(".xcuser_email").addClass("has-error");
    else if !email.match /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/
      $(".xcuser_email").addClass("has-error");
    else
      $(".xcuser_email p:first").html("");
      $(".xcuser_email").removeClass("has-error")
      $('.xcuser_email p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')

  # 检查手机号
  check_mobile: () ->
    mobile = $('#xcuser_phone').val();
    $('.xcuser_phone span:first').html('');
    if !mobile? or mobile == ""
      $(".xcuser_phone").addClass("has-error");
    else if !mobile.match /^((\(\d{2,3}\))|(\d{3}\-))?1[3,8,5]{1}\d{9}$/
      $(".xcuser_phone").addClass("has-error");
    else
      $(".xcuser_phone p:first").html("");
      $(".xcuser_phone").removeClass("has-error")
      $('.xcuser_phone p.help-block').html('<i class="glyphicon glyphicon-ok thumbsup"></i>')

   validateForm: () ->
    $(".has-error").length is 0