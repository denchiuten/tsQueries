SELECT DISTINCT 
	e.event_time::DATE AS event_date,
	hc.id AS hs_user_id,
	fs.organization_id,
	cp.child_name,
	cp.parent_name,
	map_com.property_name AS mapped_auth0_company		
FROM fullstory_o_1jfe7s_na1.events AS e
INNER JOIN fullstory_o_1jfe7s_na1.vw_fs_users AS fs
	ON e.device_id = fs.device_id
INNER JOIN hubs.contact AS hc
	ON LOWER(fs.user_email) = LOWER(hc.property_email)
	AND hc._fivetran_deleted IS FALSE
INNER JOIN hubs.contact_company AS cc
	ON hc.id = cc.contact_id
	-- primary company association type
	AND cc.type_id = 1
INNER JOIN hubs.vw_child_to_parent AS cp
	ON cc.company_id = cp.child_id
INNER JOIN hubs.company AS com
	ON cp.parent_id = com.id
	AND com._fivetran_deleted IS FALSE
LEFT JOIN plumbing.auth0_to_hubspot_company AS map
	ON fs.organization_id = map.auth0_id
LEFT JOIN hubs.company AS map_com
	ON map.company_id = map_com.id
	AND map_com._fivetran_deleted IS FALSE
WHERE
	1 = 1
	-- Exclude Terrascope employees
	AND com.id <> 9244595755
ORDER BY 1

