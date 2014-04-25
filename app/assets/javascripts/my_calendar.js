$(document).ready(function() {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar')

      .fullCalendar({
          header: {
              left: 'prev,next today',
              center: 'title'
          },
          editable: true
      })

      .on('click', '.fc-week', function() {
        var week = $(this);
        var sunday = week.children(".fc-sun").data('date').split('-').join('');

        $.ajax({
          type: "GET",
          url: '/schedules/' + sunday,
          success: function(){
            document.location.href = '/schedules/' + sunday;
          },
          error: function() {
            $('.create-week-dialogue').empty();
            $('.create-week-dialogue').append(sunday);
            $("#dialog").dialog();
          }
        });
      })
    ;

    $('body').on('click', '.new-schedule', function(){
      var sunday = $('.create-week-dialogue').text();
      $.ajax({
        type: "POST",
        url: 'schedules/',
        data: {schedule: {week_of: sunday}},
        success: function(){
          document.location.href = '/schedules/' + sunday;
        }
      });
    });
});
