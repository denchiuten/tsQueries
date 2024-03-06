SELECT date
  FROM plumbing.dates AS d
  LEFT JOIN (
  	SELECT DISTINCT start_date AS date
	FROM calendar.event
	WHERE
		1 = 1
		AND e.calendar_list_id = 'en.singapore#holiday@group.v.calendar.google.com'
  ) AS holidays
  	ON d.date = holidays.date
  WHERE
  	1 = 1 
  	AND	EXTRACT(DOW FROM date) NOT IN (0, 6) -- Skip weekends
  	AND holidays.date IS NULL