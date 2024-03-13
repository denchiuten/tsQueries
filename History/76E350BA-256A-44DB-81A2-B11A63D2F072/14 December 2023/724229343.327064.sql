SELECT 
	c.name,
	c.id,
	COUNT(m.*) AS n_messages,
	MAX(TO_DATE(TO_TIMESTAMP(LEFT(TO_CHAR(m.ts), POSITION('.' IN TO_CHAR(m.ts)) - 1)))) AS converted_date
FROM slack.message AS m
INNER JOIN slack.channel AS c
	ON m.message_channel_id = c.id
	AND c.name IS NOT NULL
GROUP BY 1,2
ORDER BY 1