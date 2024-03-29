SELECT
	fb.id AS feedback_id,
	fb.property_survey_type,
	com.id AS company_id,
	com.property_name AS company_child,
	cp.parent_name AS company_parent,
	COALESCE(opt.label, '*Sector Missing') AS sector,
	com.property_country_menu_ AS country,
	contact.property_firstname AS first_name,
	contact.property_lastname AS last_name,
	fb.property_survey_name AS survey_name,
	fb.property_survey_submission_date AS date_submitted,
	fb.created_at::DATE AS date_created,
	fb.property_csat_rating AS csat,
	fb.property_nps_rating AS nps,
	fb.property_rating AS rating,
	fb.property_survey_response,
	com_to_csm.csm_first,
	com_to_csm.csm_last,
	MAX(MAX(fb._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM hubs.customer_feedback_submissions AS fb
-- find contact associated with submission
INNER JOIN hubs.customer_feedback_submissions_to_contact AS fc
	ON fb.id = fc.from_id
-- find company associated with contact
LEFT JOIN hubs.contact_company AS cc
	ON fc.to_id = cc.contact_id
	AND cc.type_id = 1 -- ensure it's the primary company for the contact
LEFT JOIN hubs.company AS com
	ON cc.company_id = com.id
LEFT JOIN hubs.property_option AS opt
	ON com.property_sector_grouped_ = opt.value
	AND opt.property_id = 'LvhF5AouIjxudPghzI6sPeTQQis=' -- property_id for sector_grouped_
	AND opt.label NOT IN (
		'Other', 
		'Tier 2 - Industrials/CPG/Retail', 
		'Tier 3 - TMT/Fashion/Textile/Luxury', 
		'Tier 4 - Trans/Log/R.estate/Cons/Hospitality', 
		''
	)
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id
INNER JOIN hubs.contact AS contact
	ON fc.to_id = contact.id	
	AND contact.property_email NOT LIKE '%@terrascope.com'
LEFT JOIN (
	SELECT DISTINCT
		dc.company_id,
		deal.property_dealname,
		csm.first_name AS csm_first,
		csm.last_name AS csm_last
	FROM hubs.deal_company AS dc
	INNER JOIN hubs.deal AS deal
		ON dc.deal_id = deal.deal_id
		AND deal.deal_pipeline_id = 11272062 -- ID for Customer Success deal pipeline
		AND deal.property_customer_success_manager IS NOT NULL
	LEFT JOIN hubs.owner AS csm
		ON deal.property_customer_success_manager = csm.owner_id
	WHERE
		1 = 1
		AND dc.type_id = 5
) AS com_to_csm
	ON com.id = com_to_csm.company_id
WHERE
	1 = 1
	AND (com.id IS NULL OR com.id NOT IN (9244595755, 9457745973)) -- exclude submissions from Terrascope and The Neighbourhood
	AND fb.is_merged IS FALSE
	AND fb.id != 10929980569 -- exclude one duplicate submission
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18