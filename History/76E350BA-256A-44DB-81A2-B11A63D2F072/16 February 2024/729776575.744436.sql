SELECT linear_label_id
FROM plumbing.hs_ticket_to_linear_label
WHERE
	1 = 1
	AND property_id || '_' || label IN ('hs_ticket_category_Technical Support', 'technical_support_subcategories_Platform Issues');