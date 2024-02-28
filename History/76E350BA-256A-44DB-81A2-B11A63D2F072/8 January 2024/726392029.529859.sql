SELECT * FROM gcal.event
WHERE calendar_list_id NOT IN (SELECT DISTINCT id from gcal.calendar_list)