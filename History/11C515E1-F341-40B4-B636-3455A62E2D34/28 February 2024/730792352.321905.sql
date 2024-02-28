SELECT
	e._fivetran_deleted,
	e.summary,
	e.start_date
FROM calendar.event AS e
WHERE e.calendar_list_id = 'bizopsautomation@terrascope.com'