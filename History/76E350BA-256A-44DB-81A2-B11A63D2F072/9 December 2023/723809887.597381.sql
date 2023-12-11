SELECT
	c.id,
	c.name,
	SUM(CASE WHEN m.user_id = 'U03F7MMQSHJ'THEN 1 ELSE 0 END) AS am_member -- return 1 if Dennis is already a member
FROM slack.channel AS c
INNER JOIN slack.channel_member	AS m
	ON c.id = m.channel_id
WHERE
	1 = 1
	AND c.is_archived = FALSE
	AND c.is_private = FALSE
GROUP BY 1,2
HAVING SUM(CASE WHEN m.user_id = 'U0698LW7SRY' THEN 1 ELSE 0 END) = 0 -- exclude channels where Fivetran app is already a member