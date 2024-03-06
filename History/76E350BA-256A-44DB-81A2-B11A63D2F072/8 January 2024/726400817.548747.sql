DELETE FROM gcal.event
WHERE calendar_list_id NOT IN (SELECT id FROM gcal.calendar_list)