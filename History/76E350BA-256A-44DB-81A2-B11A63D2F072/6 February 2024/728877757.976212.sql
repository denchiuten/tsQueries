SELECT
	stage.ticket_state,
	stage.label,
	t.id AS ticket_object_id,
	t.property_hs_primary_company_id,
	t.property_hs_primary_company_name,
	t.property_subject,
	t.property_customer_tiering,
	t.property_hs_ticket_category,
	t.property_feedback_subcategory,
	t.property_request_access_subcategory,
	t.property_feature_request_subcategories,
	t.property_technical_support_subcategories,
	t.property_data_related_enquiries_subcategories,
	t.property_createdate AS created_datetime,
	t.property_first_agent_reply_date AS first_reply_datetime,
	t.property_time_to_close,
	t.property_time_to_first_agent_reply,
	sla.sla_status
FROM hubs.ticket AS t
LEFT JOIN hubs.ticket_pipeline_stage AS stage
	ON t.property_hs_pipeline_stage = stage.stage_id
	AND stage._fivetran_deleted IS FALSE
LEFT JOIN (
	SELECT
		opt.value AS sla_id,
		opt.label AS sla_status
	FROM hubs.property_option AS opt
	INNER JOIN hubs.property AS p
		ON opt.property_id = p._fivetran_id
		AND p.name = 'hs_time_to_close_sla_status'
) AS sla
	ON t.property_hs_time_to_close_sla_status = sla.sla_id
	
WHERE
	1 = 1
	AND t._fivetran_deleted IS FALSE