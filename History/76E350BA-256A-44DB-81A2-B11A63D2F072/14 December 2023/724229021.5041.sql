SELECT 
	c.name,
	c.id,
	COUNT(m.*) AS n_messages
FROM slack.message AS m
INNER JOIN slack.channel AS c
	ON m.message_channel_id = c.id
GROUP BY 1,2
ORDER BY 1