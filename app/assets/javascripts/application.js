// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require foundation
//= require_tree .

$(function() {
  $('.datepicker').datepicker();
  $(document).foundation();
  if (window.location.pathname == '/') {
    $.backstretch("https://s3.amazonaws.com/dialgus/workingblur.jpg");
  };

  $('.schedules').on('click', 'th[data-weekday]', function(e){

    var self = $(this);
    var weekday = self.data('weekday');
    var template = $('#detailItem');
    var destination = $('#detailview');

    // Make a clean slate if there wa any data in there before
    destination.empty();

    self.closest('form').find('tbody tr').each(function(){

      var row = $(this);

      // Create a new instance of the template
      var shift = $(template.html());

      // Set the name
      shift.find('.name').text( row.find('.name').text() );

      // Get the relevant table cells for the table header we clicked
      var selects = row.find('td[data-weekday="' + weekday + '"]');

      // Get the start and end military times
      var start = Number( selects.filter('.start').find('select').val() );
      var end = Number( selects.filter('.end').find('select').val() );

      // Set the starting and ending cells colors to indicate they're occupied
      var left = shift.find('.' + start).addClass('occupied');
      var right = shift.find('.' + end);

      // Fill in everything inbetween
      left.nextUntil(right).addClass('occupied');

      // Append the template to the destination (<tbody> within <table class="daily-planner">)
      shift.appendTo(destination);

    });

  });
});
