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
	t.property_hs_time_to_close_sla_status
FROM hubs.ticket AS t
LEFT JOIN hubs.ticket_pipeline_stage AS stage
	ON t.property_hs_pipeline_stage = stage.stage_id
	AND stage._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND t._fivetran_deleted IS FALSE