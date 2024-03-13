SELECT 
	t.id,
	t.property_hs_ticket_category,
	t.property_technical_support_subcategories,
	t.property_feedback_subcategory,
	t.property_feature_request_subcategories,
	t.property_customer_tiering,
	t.property_data_related_enquiries_subcategories,
	t.property_request_access_subcategory,
	t.property_technical_support_subcategories

FROM hubs.ticket AS t