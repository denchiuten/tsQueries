SELECT	
	'notion' AS tool,
	LOWER(not_u.email) AS email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM notion.users AS not_u
LEFT JOIN bob.employee AS emp
	ON LOWER(not_u.email) = LOWER(emp.email)
WHERE
	1 = 1
	AND not_u._fivetran_deleted IS FALSE
	AND not_u.email IS NOT NULL

UNION ALL

SELECT
	'slack' AS tool,
	LOWER(slack_u.profile_email) AS email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM slack.users AS slack_u
LEFT JOIN bob.employee AS emp
	ON LOWER(slack_u.profile_email) = LOWER(emp.email)
WHERE
	1 = 1
	AND slack_u._fivetran_deleted IS FALSE
	AND slack_u.is_bot IS FALSE
	AND slack_u.deleted IS FALSE
	
UNION ALL

SELECT
	'linear' AS tool,
	LOWER(lin_u.email) AS email,
	COALESCE(emp.internal_status, 'Unknown') AS bob_status
FROM linear.users AS lin_u
LEFT JOIN bob.employee AS emp
	ON LOWER(lin_u.email) = LOWER(emp.email)
WHERE
	1 = 1
	AND lin_u._fivetran_deleted IS FALSE
	AND lin_u.active IS TRUE