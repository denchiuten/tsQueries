SELECT
	cm.channel_id,
	c.name AS channel_name,
	COUNT(DISTINCT user_id) AS n
FROM slack.channel_member AS cm
INNER JOIN slack.channel AS c
	ON cm.channel_id = c.id
WHERE
	1 = 1
	AND cm._fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 3 DESC