SELECT
	is_private,
	COUNT(*)
FROM slack.channel
GROUP BY 1