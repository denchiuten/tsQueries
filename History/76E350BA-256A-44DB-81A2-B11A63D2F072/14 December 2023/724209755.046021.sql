SELECT 
	u.id AS linear_id, 
	slack.id AS slack_id,
	u.email 
FROM linear.users AS u
INNER JOIN slack.users AS slack
	ON u.email = slack.profile_email
WHERE u.created_at::DATE = CURRENT_DATE - 1