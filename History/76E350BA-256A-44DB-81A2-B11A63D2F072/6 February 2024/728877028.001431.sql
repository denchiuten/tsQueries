SELECT
	t.id AS ticket_id,
	t.property_hs_primary_company AS primary_company,
	t.property_hs_primary_company_id,
	t.property_hs_primary_company_name,
	t.property_subject,
	t.property_customer_tiering,
	t.property_hs_ticket_category,
	t.property_feedback_subcategory,
	t.property_request_access_subcategory,
	t.property_feature_request_subcategories,
	t.property_data_related_enquiries_subcategories,
	t.property_technical_support_subcategories,
	t.property_createdate AS created_datetime
	t.property_first_agent_reply_date AS first_reply_datetime,
	t.property_time_to_close,
	t.property_time_to_first_agent_reply
FROM hubs.ticket AS t
WHERE
	1 = 1
	AND t._fivetran_deleted IS FALSE