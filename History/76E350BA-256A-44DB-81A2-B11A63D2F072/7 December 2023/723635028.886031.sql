CREATE VIEW harvest.vw_time_entry_latest AS 
SELECT
	t.*
FROM harvest.time_entry AS t
INNER JOIN (
	SELECT
		id,
		MAX(updated_at) AS updated_at
	FROM harvest.time_entry
	GROUP BY 1
) AS latest
	ON t.id = latest.id
	AND t.updated_at = latest.updated_at