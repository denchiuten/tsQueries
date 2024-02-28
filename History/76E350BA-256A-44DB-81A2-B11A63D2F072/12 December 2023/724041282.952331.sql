CREATE VIEW hubs.vw_child_to_parent AS (
	SELECT
		child.id AS child_id,
		COALESCE(child.property_hs_parent_company_id, child.id) AS parent_id,
		child.property_name AS child_name,
		COALESCE(parent.property_name, child.property_name) AS parent_name
	FROM hubs.company AS child
	LEFT JOIN hubs.company AS parent
		ON child.property_hs_parent_company_id = parent.id
);