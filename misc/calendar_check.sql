SELECT	
	event.calendar_list_id,
	MAX(start_date_time)::DATE AS latest_date
FROM gcal.event AS event
WHERE
	1 = 1
	AND event.calendar_list_id LIKE '%terrascope.com'
GROUP BY 1
