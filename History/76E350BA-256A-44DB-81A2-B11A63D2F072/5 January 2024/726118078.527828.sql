SELECT
	e.summary,
	e.start_date_time,
	e.original_start_time_date
FROM google_calendar.event AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.start_date_time IS NOT NULL
ORDER BY 2 DESC
LIMIT 200