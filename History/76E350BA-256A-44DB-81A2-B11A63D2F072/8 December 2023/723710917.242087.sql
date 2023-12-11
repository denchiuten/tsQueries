SELECT
	att.email,
	bob.full_name AS name,
	bob.work_department AS department,
	COALESCE(bob.work_manager, 'Suresh Sundararajan') AS manager,
	COALESCE(bob.work_second_level_manager, 'Suresh Sundararajan') AS second_level_manager,
	COUNT(DISTINCT ev.id) / COUNT(DISTINCT d.week_ending_date) AS n_tentative_per_week
FROM gcal.attendee AS att
INNER JOIN bob.employee AS bob
	ON att.email = bob.email
	AND bob.internal_status = 'Active' 
INNER JOIN gcal.event AS ev
	ON att.event_id = ev.id
	AND ev.event_type NOT IN ('outOfOffice', 'focusTime')
	AND ev.status = 'confirmed'
INNER JOIN plumbing.dates AS d
	ON ev.start_date_time::DATE = d.date
	AND d.week_ending_date <= CURRENT_DATE -- include completed weeks only
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
	AND att.response_status = 'tentative'
	AND LOWER(ev.summary) NOT LIKE '%focus time%'
	AND LOWER(ev.summary) NOT LIKE '%annual leave%'
GROUP BY 1,2,3,4,5