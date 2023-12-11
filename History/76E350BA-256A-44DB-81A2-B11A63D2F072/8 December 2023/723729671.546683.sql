SELECT DISTINCT
c.*
FROM slack.channel AS c
INNER JOIN slack.message AS m
	ON c.id = m.message_channel_id