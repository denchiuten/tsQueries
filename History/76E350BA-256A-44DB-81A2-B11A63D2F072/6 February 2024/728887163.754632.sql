SELECT *
FROM gcal.event AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.calendar_list_id = '6bs27qpcsiihm2fdf6acg9a11pv9jsam@import.calendar.google.com'