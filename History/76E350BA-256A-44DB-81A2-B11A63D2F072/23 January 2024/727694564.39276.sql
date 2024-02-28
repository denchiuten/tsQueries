SELECT
	channel_id,
	COUNT(DISTINCT user_id) AS n
FROM slack.channel_member AS cm
WHERE
	1 = 1
	AND cm._fivetran_deleted IS FALSE
GROUP BY 1
ORDER BY 2 DESC