SELECT
	id,
	SUM(CASE WHEN is_locked IS TRUE THEN 1 ELSE 0 END) AS locked_rows,
	SUM(CASE WHEN is_locked IS FALSE THEN 1 ELSE 0 END) AS unlocked_rows

FROM harvest.time_entry
GROUP BY 1
ORDER BY 1