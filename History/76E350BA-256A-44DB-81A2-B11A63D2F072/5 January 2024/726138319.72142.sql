SELECT
	created,summary,
	start_date_time,
	end_date_time
FROM google_calendar.event WHERE calendar_list_id = 'c_1887d2c20idsoh29ns4km7l915fa2@resource.calendar.google.com'
ORDER BY  created DESC