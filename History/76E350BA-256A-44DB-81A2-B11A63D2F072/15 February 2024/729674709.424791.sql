WITH filtered_dates AS (
  SELECT date
  FROM plumbing.dates
  WHERE EXTRACT(DOW FROM date) NOT IN (0, 6) -- Skip weekends
),
hourly_increments AS (
  SELECT 
    fd.date,
    nt.hour_number AS hour -- Use the numbers table for hours
  FROM filtered_dates AS fd
  CROSS JOIN plumbing.hours_in_day nt
  WHERE nt.hour_number BETWEEN 9 AND 16 -- Business hours from 9 to 16 (4 PM, for a 5 PM end time)
)
SELECT 
  date,
  TO_CHAR(date + (hour - 1 || ' hours')::INTERVAL, 'YYYY-MM-DD HH24:00:00') AS business_hour
FROM hourly_increments
ORDER BY date, hour;