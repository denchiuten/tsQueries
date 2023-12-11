SELECT
	att.email,
	bob.full_name AS name,
	bob.work_department AS department,
	bob.work_manager AS manager,
	bob.work_second_level_manager AS second_level_manager,
	ev.start_date_time::DATE AS date	,
	ev.id AS event_id,
	ev.summary,
	ev.start_date_time,
	ev.end_date_time,
	DATEDIFF(MINUTE, ev.start_date_time::TIMESTAMP, ev.end_date_time::TIMESTAMP) AS total_minutes,
	MAX(MAX(att._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM gcal.attendee AS att
INNER JOIN bob.employee AS bob
	ON att.email = bob.email
	AND bob.internal_status = 'Active' 
INNER JOIN gcal.event AS ev
	ON att.event_id = ev.id
	AND ev.event_type NOT IN ('outOfOffice', 'focusTime')
	AND ev.status = 'confirmed'
-- only include meetings with > 1 attendee
INNER JOIN (
	SELECT event_id
	FROM gcal.attendee 
	GROUP BY 1
	HAVING COUNT(email) > 1
) AS multi
	ON ev.id = multi.event_id
-- identify meetings with external attendees; we'll filter out later
LEFT JOIN (
	SELECT DISTINCT 
		event_id
	FROM gcal.attendee AS att
	WHERE 
	  1 = 1
	  AND LOWER(email) NOT LIKE '%@terrascope.com'
	  AND LOWER(email) NOT LIKE '%@resource.calendar.google.com'
	  AND LOWER(email) NOT LIKE '%@bcgdv.com'
	  AND email NOT IN (
	    'calendar-notification@google.com',
	    'mayaglow@gmail.com',
	    'the.natsuko@gmail.com',
	    'jeannette82@gmail.com'
	)
) AS ext
	ON ev.id = ext.event_id
WHERE
	1 = 1	
	AND ext.event_id IS NULL -- 	filter out the meetings external attendees
	AND ev.start_date_time::DATE < CURRENT_DATE
	AND att.response_status = 'accepted'
	AND LOWER(ev.summary) NOT LIKE '%focus time%'
	AND LOWER(ev.summary) NOT LIKE '%annual leave%'