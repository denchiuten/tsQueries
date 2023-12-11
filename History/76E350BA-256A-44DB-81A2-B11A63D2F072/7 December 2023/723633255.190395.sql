SELECT
	id,
	is_locked,
	COUNT(*)

FROM harvest.time_entry
GROUP BY 1,2
ORDER BY 1,2