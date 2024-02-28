SELECT
	LOWER(s.profile_email) AS email,
	s.id AS slack_user_id,
	n.id AS notion_user_id
FROM slack.users AS s
LEFT JOIN notion.users AS n
	ON LOWER(s.profile_email) = LOWER(n.email)
	AND n._fivetran_deleted IS FALSE
	AND n.email IS NOT NULL	
WHERE
	1 = 1
	AND s._fivetran_deleted IS FALSE
	AND s.is_bot IS FALSE
	AND s.deleted IS FALSE
	AND s.profile_email IS NOT NULL