SELECT DISTINCT
	start_date AS date
FROM calendar.event AS e
WHERE
	1 = 1
	AND e.calendar_list_id = 'en.singapore#holiday@group.v.calendar.google.com'