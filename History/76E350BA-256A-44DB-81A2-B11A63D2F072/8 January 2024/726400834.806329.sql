-- 8 January 2024 17:58:48
-- 8 January 2024 16:12:26
SELECT
	calendar_list_id,
	_fivetran_deleted,
	COUNT(*)

FROM gcal.event
GROUP BY 1,2
ORDER BY 3 DESC