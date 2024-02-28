SELECT
	u.id AS user_id,
	u.name AS display_name
FROM slack.users AS u
LEFT JOIN slack.channel_member AS cm
	ON u.id = cm.user_id
	AND cm.channel_id = 'C061TE45FS5'
	AND cm._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND u._fivetran_deleted IS FALSE
	AND cm.user_id IS NULL
	AND u.is_bot IS FALSE
	AND u.deleted IS FALSE
	AND u.display_name NOT IN ('suresh', 'summer.chua', 'priyanka.mukherjee', 'joydeep')