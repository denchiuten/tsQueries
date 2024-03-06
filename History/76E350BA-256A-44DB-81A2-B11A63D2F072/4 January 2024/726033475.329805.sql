SELECT
	LOWER(slack_u.profile_email) AS email,
	slack_u.id AS user_id
FROM slack.users AS slack_u
WHERE
	1 = 1
	AND slack_u._fivetran_deleted IS FALSE
	AND slack_u.is_bot IS FALSE
	AND slack_u.deleted IS FALSE