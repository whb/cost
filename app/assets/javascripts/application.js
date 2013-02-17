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
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require_tree .
$(document).on("focus", "[data-behaviour~='datepicker']", function(e) {
  $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true, "language": "zh-CN"});
});

// ====================================================

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val(true);
  $(link).parents(".fields").hide();
  redraw_ref_budget();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var unique_content = content.replace(regexp, new_id);
  $('.fields-table').append(unique_content);
  regist_events();
}

// ====================================================

function hide_ref_budget() {
  $("[id^='ref_budget_']").hide();
}

function show_ref_budget() {
  $("select[id^=expense_items_attributes]:visible").each(function(e) {
    var category_id = $(this).val();
    if ( category_id ) {
      var ref_budget = "[id^=ref_budget_%ID%]".replace(/%ID%/, category_id);
      $(ref_budget).show();
    }
  }); 
}

function parseFix(value) {
  return parseFloat(value).toFixed(2);
}

function cal_ref_budget() {
  var category_price_map = {  
      set : function(key,value){ this[key] = parseFloat(value) },  
      get : function(key){ return $.isNumeric(this[key]) ? parseFix(this[key]) : 0 },  
      add : function(key,value){ this[key] = $.isNumeric(this[key]) ? parseFloat(this[key]) + parseFloat(value) : parseFloat(value) },  
  };

  $("select[id^=expense_items_attributes]:visible").each(function(e) {
    var category_id = $(this).val();
    if ( !$.isNumeric(category_id) ) return;

    var index = $(this).attr('id').split('_')[3];
    var price_selector = '#expense_items_attributes_' + index + '_price';
    var price = $(price_selector).val();
    if ($.isNumeric(price))  category_price_map.add(category_id, price);

    var available = "[id^=ref_budget_%ID%] .available".replace(/%ID%/, category_id);
    var current = "[id^=ref_budget_%ID%] .current".replace(/%ID%/, category_id);
    $(current).text(category_price_map.get(category_id));
    var balance = "[id^=ref_budget_%ID%] .balance".replace(/%ID%/, category_id);
    $(balance).text($(available).text() - category_price_map.get(category_id));
  }); 
}

function cal_price(object) {
  var index = object.attr('id').split('_')[3];
  var amount_selector = '#expense_items_attributes_' + index + '_amount';
  var unit_price_selector = '#expense_items_attributes_' + index + '_unit_price';
  var price_selector = '#expense_items_attributes_' + index + '_price';
  $(price_selector).val( $(amount_selector).val() * $(unit_price_selector).val() );
  $(price_selector).change();
}

function redraw_ref_budget() {
  hide_ref_budget(); 
  cal_ref_budget();
  show_ref_budget();
}

function regist_events() {
  $("select[id^=expense_items_attributes]").change(function(e) {
    redraw_ref_budget();
  });
  $("input[id^=expense_items_attributes_][id$=_price]").change(function(e) {
    redraw_ref_budget();
  });
  $("input[id^=expense_items_attributes_][id$=_amount]").change(function(e) {
    cal_price($(this));
  });
  $("input[id^=expense_items_attributes_][id$=_unit_price]").change(function(e) {
    cal_price($(this));
  });
}


$(document).ready(function(){
  // hide_ref_budget();
  // show_ref_budget();
  regist_events();

  // For fluid containers
  $('.datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "oLanguage": {
        "sProcessing":   "处理中...",
        "sLengthMenu":   "显示 _MENU_ 项结果",
        "sZeroRecords":  "没有匹配结果",
        "sInfo":         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
        "sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项",
        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        "sInfoPostFix":  "",
        "sSearch":       "搜索:",
        "sUrl":          "",
        "oPaginate": {
            "sFirst":    "首页",
            "sPrevious": "上页",
            "sNext":     "下页",
            "sLast":     "末页"
        }
    }
  });

});

