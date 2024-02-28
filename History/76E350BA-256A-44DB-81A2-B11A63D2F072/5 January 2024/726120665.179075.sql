SELECT
	e.calendar_list_id,
	l.summary,
	COUNT(e.*)
FROM google_calendar.event AS e
LEFT JOIN google_calendar.calendar_list As l
	ON e.calendar_list_id = l.id
	AND l._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 3 DESC