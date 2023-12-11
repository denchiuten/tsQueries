SELECT
	fc.from_id,
	COUNT(DISTINCT fc.to_id)
FROM hubs.customer_feedback_submissions_to_contact AS fc
GROUP BY 1
ORDER BY 2 DESC