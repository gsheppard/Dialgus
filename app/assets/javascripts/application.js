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
//= require foundation
//= require_tree .

$(document).ready(function(){

  $(document).foundation();

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

      // Set the bar's width
      var bar = shift.find('.bar');
          bar.css('width', ( (end-start) / 2400 ) * 100 + '%');

      // Append the template to the destination (<figure>)
      shift.appendTo(destination);

      // Has to happen after it's inserted, because the parent doesn't have width until it's in the DOM and rendered!
      bar.css('left', ( start / ( bar.parent().width() / 2400 )) / 100 + '%' );

    });

  });


});
