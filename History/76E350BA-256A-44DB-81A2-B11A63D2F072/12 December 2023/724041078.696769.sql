SELECT
	property_name,
	id AS child_id,
	property_hs_parent_company_id AS parent_id
FROM hubs.company
WHERE parent_id IS NOT NULL