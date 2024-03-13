SELECT date AS date
  FROM plumbing.dates
  WHERE EXTRACT(DOW FROM date) NOT IN (0, 6) -- Skip weekends