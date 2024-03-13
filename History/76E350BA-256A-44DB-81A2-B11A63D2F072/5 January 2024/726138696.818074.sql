SELECT
	calendar_list_id,
	_fivetran_deleted,
	COUNT(*)

FROM google_calendar.event
GROUP BY 1,2
ORDER BY 3 DESC