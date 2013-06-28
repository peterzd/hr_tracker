root = roots ? this

root.hide_alert = ->
  $(".alert").hide 3000
  setTimeout hide_alert, 4000
root.active_datepicker = ->
  $('div[id^=datepicker]').datetimepicker
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayBtn: true,
    minView: 3,
    keyboardNavigation: true,
    pickerPosition: 'bottom-left'

root.same_date = ->
  $("#datepicker_discussion_date").datetimepicker().on('changeDate', => $("#salary_activity_effective_date").val($("#salary_activity_discussion_date").val()))

$ ->
  # About the alerts
  $(".alert").alert()
  setTimeout hide_alert, 4000
