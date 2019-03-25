// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require materialize
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.datepicker').datepicker({
    container: 'body',
    format: 'yyyy/mm/dd',
    showMonthAfterYear: true,
    i18n: {
      cancel: 'キャンセル',
      done: '決定',
      months: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
      monthsShort: ["1 /", "2 /", "3 /", "4 /", "5 /", "6 /", "7 /", "8 /", "9 /", "10 /", "11 /", "12 /"],
      weekdays: ['日', '月', '火', '水', '木', '金', '土'],
      weekdaysShort: ['日', '月', '火', '水', '木', '金', '土'],
      weekdaysAbbrev: ['日', '月', '火', '水', '木', '金', '土']
    }
  });
  $('.sidenav').sidenav();
  $(".dropdown-trigger").dropdown();
  $('.fixed-action-btn').floatingActionButton();
  $('.tabs').tabs();
  $('.modal').modal({
    onCloseEnd: function() {
      if (document.getElementById('unlock-sign') != null) {
        window.location.reload();
      }
    } 
  });
});

$(document).on('turbolinks:before-visit', function() {
  M.Sidenav.getInstance(document.querySelector('#mobile')).destroy();
});

$(document).on('turbolinks:before-cache', function() {
  M.Sidenav.getInstance(document.querySelector('#mobile')).destroy();
});
