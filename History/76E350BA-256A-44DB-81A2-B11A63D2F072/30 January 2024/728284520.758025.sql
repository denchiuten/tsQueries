SELECT 
	name,
	id,
	name || ' - ' || id AS label_name
FROM auth0.organization
WHERE _fivetran_deleted IS FALSE
ORDER BY 1