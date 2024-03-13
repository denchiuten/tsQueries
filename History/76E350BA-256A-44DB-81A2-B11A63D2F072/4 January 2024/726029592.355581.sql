SELECT
	c.name,
	COUNT(m.*)
FROM slack.channel AS c
INNER JOIN slack.message AS m
	ON c.id = m.message_channel_id
WHERE
	1 = 1
	AND c._fivetran_deleted IS FALSE
-- 	AND m._fivetran_deleted IS FALSE
GROUP BY 1
ORDER BY 2 DESC