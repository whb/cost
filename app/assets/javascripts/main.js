$(document).on("focus", "[data-behaviour~='datepicker']", function(e) {
  $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true, "language": "zh-CN"});
});

// ====================================================

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val(true);
  $(link).parents(".fields").hide();
  redraw_ref_budget();
  update_summary();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var unique_content = content.replace(regexp, new_id);
  $('.fields-table').append(unique_content);
  
  var new_name_selector = "input[id$=_%ID%_name]".replace(/%ID%/, new_id);
  $(new_name_selector).typeahead({
    source: function (name, process) {
      return $.get('/lookup/cost_names', { q: name }, function (data) {
        return process(data);
      });
    },
    items: 10
  });

  var new_unit_selector = "input[id$=_%ID%_unit]".replace(/%ID%/, new_id);
  $(new_unit_selector).typeahead({
    source: function (unit, process) {
      return $.get('/lookup/units', { q: unit }, function (data) {
        return process(data);
      });
    },
    items: 10, minLength: 0
  });

  // one select only should run once
  var new_category_selector = "select[id$=_%ID%_category_id]".replace(/%ID%/, new_id);
  $(new_category_selector).select2();

  regist_events();
}

// ====================================================

function hide_ref_budget() {
  $("[id^='ref_budget_']").hide();
}

function show_ref_budget() {
  $("select[id*=_attributes_]:visible").each(function(e) {
    var category_id = $(this).val();
    if ( category_id ) {
      var match_category_id = category_matched_budget_category[category_id];
      var ref_budget = "[id=ref_budget_%ID%]".replace(/%ID%/, match_category_id);
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

  $("select[id*=_attributes_]:visible").each(function(e) {
    var category_id = $(this).val();
    if ( !$.isNumeric(category_id) ) return;
    var match_category_id = category_matched_budget_category[category_id];

    var tr = $(this).parents(".fields");
    var price_selector = "input[id*=_attributes_][name$='[price]']";
    var price = tr.find(price_selector).val();
    if ($.isNumeric(price))  category_price_map.add(match_category_id, price);

    var available = "[id=ref_budget_%ID%] .available".replace(/%ID%/, match_category_id);
    var current = "[id=ref_budget_%ID%] .current".replace(/%ID%/, match_category_id);
    $(current).text(category_price_map.get(match_category_id));
    var balance = "[id=ref_budget_%ID%] .balance".replace(/%ID%/, match_category_id);
    $(balance).text($(available).text() - category_price_map.get(match_category_id));
  }); 
}

function cal_price(pinput) {
  var tr = $(pinput).parents(".fields");
  var amount = tr.find("input[id$=_amount]").val();
  var unit_price = tr.find("input[id$=_unit_price]").val();

  var price_selector = "input[id*=_attributes_][name$='[price]']";
  tr.find(price_selector).val(amount * unit_price);
  tr.find(price_selector).change();
}

function redraw_ref_budget() {
  hide_ref_budget(); 
  cal_ref_budget();
  show_ref_budget();
}

function update_summary() {
  var sum = 0;
  $("input[id*=_attributes_][name$='[price]']:visible").each(function(e) {
    price = parseFloat($(this).val())
    if (!isNaN(price)) sum += price;
  }); 
  $("input[id=reimbursement_amount]").val(sum.toFixed(2));
}

function regist_events() {
  $("select[id*=_attributes_]").change(function(e) {
    redraw_ref_budget();
  });
  $("input[id*=_attributes_][name$='[price]']").change(function(e) {
    redraw_ref_budget();
    update_summary();
  });
  $("input[id*=_attributes_][id$=_amount]").change(function(e) {
    cal_price(this);
  });
  $("input[id*=_attributes_][id$=_unit_price]").change(function(e) {
    cal_price(this);
  });
}

$(document).ready(function(){
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

  $("#toggle").click (function() {
    $("#reimbursed_expenses").toggle();
  });


  $("input[id*=_attributes_][id$=_name]").typeahead({
    source: function (name, process) {
      return $.get('/lookup/cost_names', { q: name }, function (data) {
        return process(data);
      });
    },
    items: 10
  });

  // minLength: 0    need to patch typeahead.js
  $("input[id*=_attributes_][id$=_unit]").typeahead({
    source: function (unit, process) {
      return $.get('/lookup/units', { q: unit }, function (data) {
        return process(data);
      });
    },
    items: 10, minLength: 0
  });

  // one select only should run once
  $("select[id*=_attributes_]").select2();

  // pdf iframe print
  $("#reimbursement_print").click(function(e) {
    window.frames["reimbursement_pdf"].focus();
    window.frames["reimbursement_pdf"].print();
  });

  $("#reimbursement_print_left").click(function(e) {
    window.frames["reimbursement_pdf_left"].focus();
    window.frames["reimbursement_pdf_left"].print();
  });

  $("#reimbursement_print_right").click(function(e) {
    window.frames["reimbursement_pdf_right"].focus();
    window.frames["reimbursement_pdf_right"].print();
  });

  // auto focus first input EXCEPT expense and reimbursment form
  $(function() {
    $(":text:visible:enabled:not([readonly]):first").not("form.disable_auto_focus input").focus();
  });

  // regenerate expense sn
  $("#new_expense").find(".error").find("input[id=expense_sn]").click(function() {
    $.ajax({
      url: "/expenses/generate_sn",
      dataType: 'text',
      success: function(data){
        $("#expense_sn").val(data);
      } 
    }); 
  });

  $("#new_reimbursement").find(".error").find("input[id=reimbursement_sn]").click(function() {
    $.ajax({
      url: "/reimbursements/generate_sn",
      dataType: 'text',
      success: function(data){
        $("#reimbursement_sn").val(data);
      } 
    }); 
  });

  $("#organization_id").change(function(e) {
     $("#select_organization_id").submit();
  });

  $("#category_id").change(function(e) {
     $("#select_category_id").submit();
  });

});

