// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require snapsvg
//= require services/api_client
//= require game_controller
//= require codemirror
//= require codemirror/modes/ruby
//= require world

$(function(){
  $(document.body).on("ajax:success", "[data-replace]", function(e, data, status, xhr){
    var destination = $(this).data("replace");
    $(destination).replaceWith(data);
  });

  // $(document.body).on("ajax:success", '[data-append]', function(e, data, status, xhr){
  //   var destination = $(this).data("append");
  //   $(destination).append(data);
  // });

  // $(document.body).on("ajax:success", '[data-prepend]', function(e, data, status, xhr){
  //   var destination = $(this).data("prepend");
  //   $(destination).prepend(data);
  // });

  // $(document.body).on("ajax:success", '[data-delete]', function(e, data, status, xhr){
  //   var destination = $(this).data("delete");
  //   $(destination).remove();
  // });
});
