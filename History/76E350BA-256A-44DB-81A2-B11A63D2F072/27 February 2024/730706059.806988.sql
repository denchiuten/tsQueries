SELECT *
FROM calendar.event AS e
WHERE
	1 = 1
	AND e.calendar_list_id = 'en.singapore#holiday@group.v.calendar.google.com'
ORDER BY start_date DESC