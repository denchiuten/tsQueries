SELECT *
FROM calendar.event AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.calendar_list_id = 'en.singapore#holiday@group.v.calendar.google.com'
ORDER BY 1