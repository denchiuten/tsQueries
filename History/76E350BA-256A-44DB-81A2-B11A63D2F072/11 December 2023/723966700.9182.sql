SELECT
	int_stages.label AS int_stage,
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
GROUP BY 1
ORDER BY 1