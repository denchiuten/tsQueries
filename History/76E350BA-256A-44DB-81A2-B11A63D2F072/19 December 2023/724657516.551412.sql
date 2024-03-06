SELECT
	lissue.id AS linear_id,
	att.url,
	jissue.key AS jira_key,
	jissue.id AS jira_id
FROM linear.issue AS lissue
INNER JOIN linear.attachment AS att
	ON lissue.id = att.issue_id
	AND att.url IS NOT NULL
LEFT JOIN jra.issue AS jissue
	ON att.url = 'https://gpventure.atlassian.net/browse' || jissue.key