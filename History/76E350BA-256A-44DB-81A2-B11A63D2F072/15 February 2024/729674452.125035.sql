WITH filtered_dates AS (
  SELECT date
  FROM plumbing.dates
  WHERE EXTRACT(DOW FROM date) NOT IN (0, 6) -- Skip weekends
),
hourly_increments AS (
  SELECT 
    date,
    GENERATE_SERIES(9, 16, 1) AS hour -- Generates hours from 9 to 16 (4 PM, for a 5 PM end time)
  FROM filtered_dates
),
SELECT 
	date,
    TO_CHAR(date + (hour || ' hours')::INTERVAL, 'YYYY-MM-DD HH24:00:00') AS business_hour
FROM hourly_increments
ORDER BY 1,2