SELECT
	'linear' AS tool,
	lin_u.email AS email,
	lin_u.name AS name,
	emp.internal_status AS bob_status
FROM linear.users AS lin_u
LEFT JOIN bob.employee AS emp
	ON lin_u.email = emp.email
WHERE
	1 = 1
	AND lin_u._fivetran_deleted IS FALSE
	AND lin_u.active IS TRUE