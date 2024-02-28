SELECT
	com.property_name AS company_name,
	com.id AS company_id,
	sales_deal.deal_name AS sales_deal_name,
	sales_deal.deal_id AS sales_deal_id
FROM hubs.company AS com
INNER JOIN hubs.deal_company AS dc
	ON com.id = dc.company_id
	AND dc.type_id = 5
LEFT JOIN (
	SELECT
		deal.property_dealname AS deal_name,
		deal.deal_id
	FROM hubs.deal AS deal
	INNER JOIN hubs.deal_pipeline_stage AS stage
		ON deal.deal_pipeline_stage_id = stage.stage_id
		AND stage.label = '#09 WON'
) AS sales_deal
	ON dc.deal_id = sales_deal.deal_id
WHERE
	1 = 1