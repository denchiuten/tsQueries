SELECT
	fb.id AS feedback_id,
	fb.property_survey_type,
	com.id AS company_id,
	com.property_name AS company,
	com.property_sector_grouped_ AS sector,
	com.property_country_menu_ AS country,
	fb.property_survey_name,
	fb.property_survey_submission_date AS date_submitted,
	fb.created_at::DATE AS date_created,
	fb.property_csat_rating AS csat,
	fb.property_nps_rating AS nps,
	fb.property_rating AS rating,
	fb.property_submission,
	MAX(MAX(fb._fivetran_synced) OVER())::TIMESTAMP AS data_up_to
FROM hubs.customer_feedback_submissions AS fb
INNER JOIN hubs.customer_feedback_submissions_to_company AS fc
	ON fb.id = fc.from_id
INNER JOIN hubs.company AS com
	ON fc.to_id = com.id
WHERE
	1 = 1
	AND com.id NOT IN (9244595755, 9457745973) -- exclude submissions from Terrascope and The Neighbourhood
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12