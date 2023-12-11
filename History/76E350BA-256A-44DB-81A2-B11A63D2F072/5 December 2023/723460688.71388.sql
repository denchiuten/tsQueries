SELECT
	fb.id AS feedback_id,
	fb.property_survey_type,
	com.id AS company_id,
	com.property_name AS company,
	com.property_sector_grouped_ AS sector,
	com.property_country_menu_ AS country,
	contact.property_firstname AS first_name,
	contact.property_lastname AS last_name,
	fb.property_survey_name,
	fb.property_survey_submission_date AS date_submitted,
	fb.created_at::DATE AS date_created,
	fb.property_csat_rating AS csat,
	fb.property_nps_rating AS nps,
	fb.property_rating AS rating,
	fb.property_survey_response,
	csm.first_name AS csm_first,
	csm.last_name AS csm_last,
	MAX(MAX(fb._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM hubs.customer_feedback_submissions AS fb
-- find contact associated with submission
INNER JOIN hubs.customer_feedback_submissions_to_contact AS fc
	ON fb.id = fc.from_id
-- find company associated with contact
INNER JOIN hubs.contact_company AS cc
	ON fc.to_id = cc.contact_id
	AND cc.type_id = 1 -- ensure it's the primary company for the contact
INNER JOIN hubs.company AS com
	ON cc.company_id = com.id
INNER JOIN hubs.contact AS contact
	ON fc.to_id = contact.id	
INNER JOIN hubs.deal_company AS dc
	ON com.id = dc.company_id
	AND dc.type_id = 5
INNER JOIN hubs.deal AS deal
	ON dc.deal_id = deal.deal_id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
INNER JOIN hubs.owner AS csm
	ON deal.property_customer_success_manager = csm.owner_id
WHERE
	1 = 1
	AND com.id NOT IN (9244595755, 9457745973) -- exclude submissions from Terrascope and The Neighbourhood
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17