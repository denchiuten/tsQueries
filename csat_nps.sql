SELECT DISTINCT name, label

FROM hubs.property
WHERE hubspot_object = 'customer_feedback_submissions'

SELECT
	feedback.id AS feedback_id,
FROM hubs.customer_feedback_submissions AS feedback
INNER JOIN hubs.property AS csat
	