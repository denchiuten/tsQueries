SELECT
	h.issue_id,
	i.key AS issue_key,
	u.email AS updated_by
	'https://gpventure.atlassian.net/browse/' || i.key AS url,
	MAX(h.time::DATE) AS latest_update
FROM jra.issue_field_history AS h
INNER JOIN jra.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN jra.user AS u
	ON h.author_id = u.id	
WHERE
	1 = 1
	AND h.time::DATE >= "22-01-2024"
GROUP BY 1,2,3,4
ORDER BY 5 DESC