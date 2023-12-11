SELECT DISTINCT
	fb.id AS feedback_id,
	contact.property_email AS email,	
	fb.property_survey_name AS survey_name,
	fb.property_survey_submission_date AS date_submitted,
	fb.created_at::DATE AS date_created,
	fb.property_rating AS rating
FROM hubs.customer_feedback_submissions AS fb
-- find contact associated with submission
INNER JOIN hubs.customer_feedback_submissions_to_contact AS fc
	ON fb.id = fc.from_id
INNER JOIN hubs.contact AS contact
	ON fc.to_id = contact.id	
WHERE
	1 = 1