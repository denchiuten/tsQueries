SELECT
	'slack' AS tool,
	slack_u.profile_email AS email,
	slack_u.name AS name,
	emp.internal_status AS bob_status
FROM slack.users AS slack_u
LEFT JOIN bob.employee AS emp
	ON slack_u.profile_email = emp.email
WHERE
	1 = 1
	AND slack_u._fivetran_deleted IS FALSE
	AND slack_u.is_bot IS FALSE