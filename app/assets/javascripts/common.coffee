$ ->
  $('div[id^=datepicker]').datetimepicker
	  pickTime: false
  # About the alerts
  $(".alert").alert()

	callback = -> $(".alert").hide 3000
	setTimeout callback, 4000
