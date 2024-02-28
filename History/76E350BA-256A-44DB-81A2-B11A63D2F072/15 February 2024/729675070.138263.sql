WITH filtered_dates AS (
  SELECT d.date
  FROM plumbing.dates AS d
  LEFT JOIN (
  	SELECT DISTINCT start_date AS date
	FROM calendar.event
	WHERE
		1 = 1
		AND calendar_list_id = 'en.singapore#holiday@group.v.calendar.google.com'
  ) AS holidays
  	ON d.date = holidays.date
  WHERE
  	1 = 1 
  	AND	EXTRACT(DOW FROM d.date) NOT IN (0, 6) -- Skip weekends
  	AND holidays.date IS NULL
)

SELECT 
	fd.date,
    nt.hour_number AS hour,
    TO_CHAR(fd.date + (nt.hour_number || ' hours')::INTERVAL, 'YYYY-MM-DD HH24:00:00') AS timestamp
FROM filtered_dates AS fd
CROSS JOIN plumbing.hours_in_day nt
WHERE nt.hour_number BETWEEN 9 AND 16 -- Business hours from 9 to 16 (4 PM, for a 5 PM end time)