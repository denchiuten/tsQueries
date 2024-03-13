WITH query AS (
	SELECT
		com.property_sector_grouped_ AS sector,
		com.property_country_menu_ AS country,
		current_stage.label AS current_stage,
		int_stages.label AS int_stage,
		o.first_name || ' ' || o.last_name AS bdm,
		COUNT(DISTINCT deal.deal_id) AS n
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
		AND int_stages.pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'
	INNER JOIN hubs.owner AS o
		ON deal.owner_id = o.owner_id
	WHERE
		1 = 1
		AND deal.deal_pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'
	GROUP BY 1,2,3,4,5
)

SELECT 
	'delta' AS type,
	query.*
FROM query

UNION ALL

SELECT
	'baseline' AS type,
	sector,
	country,
	current_stage,
	int_stage,
	bdm,
	-n
FROM query