SELECT
	contact.property_email AS email,
	contact.property_firstname AS first_name,
	contact.property_lastname AS last_name,
	com.property_name AS company,
	cp.parent_name AS parent,
	com.id AS child_id,
	cp.parent_id
FROM auth0.users AS u
LEFT JOIN hubs.contact AS contact 
	ON u.email = '''' || contact.property_email
LEFT JOIN hubs.contact_company AS cc
	ON contact.id = cc.contact_id
	AND cc.type_id = 1 --primary company only
LEFT JOIN hubs.company AS com
	ON cc.company_id = com.id
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id
WHERE
	1 = 1
	AND com.id != 9244595755 -- exclude Terrascope
-- 	AND u.email NOT LIKE '%@terrascope.com'
ORDER BY 1