SELECT
	fb.id,
	fb.created_at::DATE AS created,
	contact.property_email AS email,	
	fb.property_survey_name AS survey_name,
	fb.property_survey_submission_date AS date_submitted,
	fb.property_rating AS rating,
	fb.property_csat_rating,
	fb.property_nps_rating,
	SUM(COUNT(DISTINCT fb.id)) OVER(
		PARTITION BY 
			contact.property_email, 
			survey_name, 
			property_survey_submission_date::DATE, 
			property_rating, 
			property_csat_rating, 
			property_nps_rating
			) AS n
FROM hubs.customer_feedback_submissions AS fb
-- find contact associated with submission
INNER JOIN hubs.customer_feedback_submissions_to_contact AS fc
	ON fb.id = fc.from_id
INNER JOIN hubs.contact AS contact
	ON fc.to_id = contact.id	
WHERE
	1 = 1
	AND fb.property_survey_name LIKE '%CSM%'
GROUP BY 1,2,3,4,5,6,7,8