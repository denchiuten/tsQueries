SELECT
	u.id AS user_id,
	u.name AS display_name,
	cm.user_id IS NOT NULL AS in_channel
FROM slack.users AS u
LEFT JOIN slack.channel_member AS cm
	ON u.id = cm.user_id
	AND cm.channel_id = 'C061TE45FS5'
	AND cm._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND u._fivetran_deleted IS FALSE