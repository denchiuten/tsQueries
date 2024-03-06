SELECT
	deal.deal_id,
	deal.property_dealname AS deal,
	deal.property_createdate::DATE AS date_created,
	com.property_name AS company,
	com.property_sector_grouped_ AS sector,
	com.property_country_menu_ AS country,
	current_stage.label AS current_stage,
	int_stages.label AS int_stage,
	ds._fivetran_start::DATE AS date_entered,
	CASE 
		WHEN deal.deal_pipeline_stage_id = ds.value THEN NULL
		ELSE ds._fivetran_end::DATE 
		END AS date_exited,
	COALESCE(deal.property_hs_tcv, deal.property_amount) AS tcv,
	o.first_name || o.last_name AS bdm	
	SUM(COUNT(DISTINCT ds.value)) OVER (PARTITION BY deal.deal_id) AS n_stages
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS current_stage
	ON deal.deal_pipeline_stage_id = current_stage.stage_id
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
INNER JOIN hubs.deal_stage AS ds
	ON deal.deal_id = ds.deal_id
INNER JOIN hubs.deal_pipeline_stage AS int_stages
	ON ds.value = int_stages.stage_id
INNER JOIN hubs.owner AS o
	ON deal.owner_id = o.owner_id
WHERE
	1 = 1
	AND deal.deal_pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12