SELECT 
	c.name,
	c.id,
	COUNT(m.*) AS n_messages,
	MAX(m.ts) As max_ts
FROM slack.message AS m
INNER JOIN slack.channel AS c
	ON m.message_channel_id = c.id
	AND c.name IS NOT NULL
	AND c.is_archived = FALSE
GROUP BY 1,2
ORDER BY 1