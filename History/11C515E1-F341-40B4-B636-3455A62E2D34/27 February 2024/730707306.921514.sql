SELECT *
FROM linear.label
WHERE 
	is_group IS TRUE
	AND _fivetran_deleted IS FALSE
ORDER BY name