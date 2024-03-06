SELECT
	LOWER(s.profile_email) AS email,
	b.id AS bob_user_id,
	s.id AS slack_user_id,
	n.id AS notion_user_id,
	l.id AS linear_user_id,
	au.id AS auth0_user_id
FROM slack.users AS s
LEFT JOIN bob.employee AS b
	ON LOWER(s.profile_email) = LOWER(b.email)
	AND b._fivetran_deleted IS FALSE
	AND b.internal_status = 'Active'
LEFT JOIN notion.users AS n
	ON LOWER(s.profile_email) = LOWER(n.email)
	AND n._fivetran_deleted IS FALSE
	AND n.email IS NOT NULL	
LEFT JOIN linear.users AS l
	ON LOWER(s.profile_email) = LOWER(l.email)
	AND l._fivetran_deleted IS FALSE
	AND l.active IS TRUE
LEFT JOIN auth0.users AS au
	ON LOWER(s.profile_email) = LOWER(au.email)
	AND au._fivetran_deleted IS FALSE
	AND au.email LIKE '%@terrascope.com'
WHERE
	1 = 1
	AND s._fivetran_deleted IS FALSE
	AND s.is_bot IS FALSE
	AND s.deleted IS FALSE
	AND s.profile_email IS NOT NULL