SELECT DISTINCT
	c.id,
	c.name
FROM slack.channel AS c
WHERE 
	c."name" IS NOT NULL
	AND is_archived = FALSE