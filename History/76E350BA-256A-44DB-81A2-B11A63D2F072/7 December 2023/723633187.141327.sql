SELECT
id,
COUNT(*)

FROM harvest.time_entry
GROUP BY 1
ORDER BY 2 DESC