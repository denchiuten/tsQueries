SELECT	
	not_u.email,
	not_u.name,
	not_
	emp.internal_status AS bob_status
FROM notion.users AS not_u
LEFT JOIN bob.employee AS emp
	ON not_u.email = emp.email
WHERE
	1 = 1
	AND not_u._fivetran_deleted IS FALSE
ORDER BY 3, 1