SELECT DISTINCT
	fb.record_id,
	fb.survey_name,
	fb.date_formatted_::DATE AS date_submitted,
	fb.object_create_date_time_formatted_::DATE AS date_created,
	fb.object_last_modified_date_time_formatted_::DATE AS date_last_modified,
	COALESCE(opt.label, '*Sector Missing') AS sector,
	com.property_country_menu_ AS country,
	com.id AS company_id,
	cp.parent_name AS company_parent,
	com.property_name AS company_child,
	c.id AS contact_id,
	c.property_firstname AS first_name,
	c.property_lastname AS last_name,
	SUBSTRING(fb.submission_name FROM POSITION('NPS - ' IN fb.submission_name) +6) AS submitter_email,
	fb.how_would_you_rate_your_overall_experience_with_terrascope_number_1 AS overall_rating,
	cfs.property_csat_rating AS csat,
	fb.rating AS nps_score,
	INITCAP(fb.feedback_sentiment) AS promoter_tier,
	fb.response,
	com_to_csm.csm_first,
	com_to_csm.csm_last
FROM google_sheets.hubspot_feedback_responses AS fb
INNER JOIN hubs.contact AS c
	ON fb.contact_id = c.id
-- 	ON c.property_email = SUBSTRING(fb.submission_name FROM POSITION('NPS - ' IN fb.submission_name) +6)
	AND c.property_email NOT LIKE '%@terrascope.com' -- exclude internal submission by Terrascope employees
	AND c._fivetran_deleted IS FALSE
INNER JOIN hubs.customer_feedback_submissions_to_contact AS cfsc
	ON fb.contact_id = cfsc.to_id
INNER JOIN hubs.customer_feedback_submissions AS cfs
	ON cfsc.from_id = cfs.id
	AND cfs._fivetran_deleted IS FALSE
LEFT JOIN hubs.contact_company AS cc
	ON cfsc.to_id = cc.contact_id
	AND cc.type_id = 1 -- ensure it's the primary company for the contact
LEFT JOIN hubs.company AS com
	ON cc.company_id = com.id	
	AND com._fivetran_deleted IS FALSE
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
-- idk what this is for, think its to identify the first and last owner
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
	AND fb.record_id != '233829743769' -- exclude one duplicate submission (feedback ID: 10929980569)