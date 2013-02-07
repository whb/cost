// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val(true);
  $(link).parents(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var unique_content = content.replace(regexp, new_id);
  $('.fields-table').append(unique_content);
}

$(document).on("focus", "[data-behaviour~='datepicker']", function(e) {
  $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true, "language": "zh-CN"});
});



function hide_ref_budget() {
  $("[id^='ref_budget_']").hide();
}

function show_ref_budget() {
  $("select[id^=expense_items_attributes]").each(function(e) {
    var id = $(this).val();
    if ( id ) {
      cal_ref_budget(id);

      var ref_budget = "[id^=ref_budget_%ID%]".replace(/%ID%/, id);
      $(ref_budget).show();
    }
  }); 
}

function cal_ref_budget(id) {
  // $("input[id^=expense_items_attributes_][id$=_price]").each(function(e) {
    
  // }); 

  var current = "[id^=ref_budget_%ID%] .current".replace(/%ID%/, id);
  $(current).text('999');
  var balance = "[id^=ref_budget_%ID%] .balance".replace(/%ID%/, id);
  $(balance).text('888');
}

function redraw_ref_budget() {
  hide_ref_budget(); 
  show_ref_budget();
}


$(document).ready(function(){
  hide_ref_budget();
  $("select[id^=expense_items_attributes]").change(function(e) {
    redraw_ref_budget();
  });
  $("input[id^=expense_items_attributes_][id$=_price]").change(function(e) {
    redraw_ref_budget();
  });
});

