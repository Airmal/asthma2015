window.yunmed_index =
  init: () ->
    $("#big-banner").owlCarousel({
      autoPlay : 3000,
      slideSpeed : 300,
      paginationSpeed : 400,
      singleItem:true
    });

    $(".index_lastest_program h2 li").bind 'click', (event) ->
      $(".index_lastest_program h2 li.active").attr('class', '');
      $(this).attr('class', 'active');
      $('.index_lastest_program h2 .pull-left span').text($(this).text());
      left_distence = $(this).prev().length * (-1120)
      $('.index_lastest_program .program_list .scroll_program').css('left', left_distence);
