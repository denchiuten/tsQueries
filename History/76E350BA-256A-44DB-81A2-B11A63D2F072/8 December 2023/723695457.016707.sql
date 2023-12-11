SELECT
	att.email,
	event.*
FROM gcal.event AS event
INNER JOIN gcal.attendee AS att
	ON "event".id = att.event_id
WHERE event.summary = '[Block] AWS Marketplace Bootcamp'