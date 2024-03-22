CREATE OR REPLACE VIEW hubs.vw_deal_property_history AS
SELECT
	h.deal_id,
	h.name AS field_name,
	h.source,
	h.source_id,
	h.timestamp AS valid_from,
	h.value,
	LEAD(timestamp) OVER (
		PARTITION BY 
			h.deal_id,
			h.name 
		ORDER BY 
			h.timestamp
	) AS valid_to
FROM hubs.deal_property_history AS h
INNER JOIN hubs.deal AS d
	ON h.deal_id = d.deal_id
	AND d.deal_pipeline_id = 19800993 -- id for sales_pipeline_v2
	AND d._fivetran_deleted IS FALSE;