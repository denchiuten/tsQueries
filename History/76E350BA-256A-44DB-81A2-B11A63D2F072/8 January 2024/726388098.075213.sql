-- 5 January 2024 17:06:31
SELECT
	created,summary,
	start_date_time,
	end_date_time
FROM gcal.event 
WHERE
	1 = 1
	AND _fivetran_deleted IS FALSE
	AND calendar_list_id = 'dennis@terrascope.com'
-- 	AND calendar_list_id = 'c_1887d2c20idsoh29ns4km7l915fa2@resource.calendar.google.com'
ORDER BY  created DESC