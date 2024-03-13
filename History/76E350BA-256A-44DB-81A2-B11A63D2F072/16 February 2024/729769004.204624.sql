DROP TABLE IF EXISTS plumbing.test;
CREATE TABLE plumbing.test AS (
SELECT 
		d.date,
	    nt.hour_number AS hour,
	    TO_CHAR(d.date + (nt.hour_number || ' hours')::INTERVAL, 'YYYY-MM-DD HH24:00:00') AS timestamp,
		(d.date + (nt.hour_number) * INTERVAL '1 hour') AT TIME ZONE 'Asia/Singapore' AT TIME ZONE 'UTC' AS timestamp_iso_utc,
		(d.date + (nt.hour_number) * INTERVAL '1 hour') AS timestamp_iso_sg
	FROM plumbing.dates AS d
	CROSS JOIN plumbing.hours_in_day AS nt
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
	  	AND nt.hour_number BETWEEN 9 AND 16 -- Business hours from 9 to 16 (4 PM, for a 5 PM end time)
	  	AND d.date <= CURRENT_DATE + 365  -- Only go out 1 year into the future
  	ORDER BY 1,2


)