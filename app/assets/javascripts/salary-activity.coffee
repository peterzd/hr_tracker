$ ->
	$("#datepicker_discussion_date").datetimepicker().on('changeDate', => $("#salary_activity_effective_date").val($("#salary_activity_discussion_date").val()))
