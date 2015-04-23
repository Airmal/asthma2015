// 构建节目控制器
var programs_control = {
  init: function(socket_addr, image_tag, image_array, program_id) {
    dispatcher = new WebSocketRails(socket_addr);
    img_tag = image_tag;
    img_array = image_array;
    pid = program_id;
  },

  events_bind: function(){
    dispatcher.bind('program.go_ahead', this.go_ahead);
  },

  control_success: function(data){
    console.log('Success!');
    $('#current_page_index').html(data.current_page);
  },

  control_failure: function(response){
    console.log("Failure!");
    console.log(response);
  },

  save_timeLine: function(){
    $.ajax({
      url: '/save_time_line',
      type: 'POST',
      data: {'program_id': $('#program_id').val()},
      dataType: 'json',
      success: function(data){
        console.log(data['time_line'])
      }
    })
  },

  prev_page: function(){
    dispatcher.trigger('program.prev_page', '', this.control_success, this.control_failure);
    // $('#control_PPT').attr("src") = img_array[data.current_page];
  },

  next_page: function(){
    today = new Date;
    day = today.getTime()/1000;
    data = { program_id: $('#program_id').val(), time: parseInt(day) };
    dispatcher.trigger('program.next_page', data, this.control_success, this.control_failure);
    // $('#control_PPT').attr("src") = img_array[data.current_page];
  },

  go_ahead: function(data){
    img_tag.attr("src", img_array[data.current_page]);

    // if (data.current_page == 0){
    //   $('#page_li_1').attr("src", img_array[data.current_page]);
    //   if (img_array[data.current_page + 1] != undefined){
    //     $('#page_li_2').attr("src", img_array[data.current_page + 1]);
    //   }
    //   if (img_array[data.current_page + 2] != undefined){
    //     $('#page_li_3').attr("src", img_array[data.current_page + 2]);
    //   }
    // } else if (data.current_page == img_array.length - 1){
    //   $('#page_li_1').attr("src", img_array[data.current_page-2]);
    //   $('#page_li_2').attr("src", img_array[data.current_page-1]);
    //   $('#page_li_3').attr("src", img_array[data.current_page]);
    // } else {
    //   $('#page_li_1').attr("src", img_array[data.current_page-1]);
    //   $('#page_li_2').attr("src", img_array[data.current_page]);
    //   $('#page_li_3').attr("src", img_array[data.current_page+1]);
    // }
    $('#li_1').removeClass('select-image');
    $('#li_2').removeClass('select-image');
    $('#li_3').removeClass('select-image');

    if (data.current_page == 0){
      $('#li_1').addClass('select-image');
    } else if (data.current_page == img_array.length - 1){
      $('#li_3').addClass('select-image');
    } else{
      $('#li_2').addClass('select-image');
      $('#page_li_2').attr("src", img_array[data.current_page]);
      if (img_array[data.current_page-1] != undefined){
        $('#page_li_1').attr("src", img_array[data.current_page-1]);
      }
      if (img_array[data.current_page+1] != undefined){
        $('#li_a_3').css("visibility", "visible");
        $('#page_li_3').attr("src", img_array[data.current_page+1]);
      } else {
        $('#li_a_3').css("visibility", "hidden");
      }
    }


  }
};