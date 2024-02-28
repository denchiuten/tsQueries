SELECT	
	name || id AS label_name
FROM auth0.organization
WHERE _fivetran_deleted IS FALSE