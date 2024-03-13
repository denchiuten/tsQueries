SELECT
	c.id,
	c.name,
	COUNT(DISTINCT m.parent_message_ts) AS n_messages
FROM slack.channel AS c
INNER JOIN slack.message AS m
	ON c.id = m.message_channel_id
WHERE
	1 = 1
	AND c.is_archived = FALSE
GROUP BY 1,2
ORDER BY 2