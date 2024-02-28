SELECT	
	not_u.email,
	not_u.name,
	emp.internal_status AS bob_status
FROM notion.users AS not_u
LEFT JOIN bob.employee AS emp
	ON not_u.email = emp.email