SELECT	
	'notion' AS tool,
	not_u.email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM notion.users AS not_u
LEFT JOIN bob.employee AS emp
	ON not_u.email = emp.email
WHERE
	1 = 1
	AND not_u._fivetran_deleted IS FALSE
	AND not_u.email IS NOT NULL

UNION ALL

SELECT
	'slack' AS tool,
	slack_u.profile_email AS email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM slack.users AS slack_u
LEFT JOIN bob.employee AS emp
	ON slack_u.profile_email = emp.email
WHERE
	1 = 1
	AND slack_u._fivetran_deleted IS FALSE
	AND slack_u.is_bot IS FALSE
	AND slack_u.deleted IS FALSE
	
UNION ALL

SELECT
	'linear' AS tool,
	lin_u.email AS email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM linear.users AS lin_u
LEFT JOIN bob.employee AS emp
	ON lin_u.email = emp.email
WHERE
	1 = 1
	AND lin_u._fivetran_deleted IS FALSE
	AND lin_u.active IS TRUE