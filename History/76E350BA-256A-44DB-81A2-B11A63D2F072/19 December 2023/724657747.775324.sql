SELECT
	lissue.id AS linear_issue_id,
	team.name AS team_name,
	team.id AS team_id,
	jissue.key AS jira__issue_key,
	jissue.id AS jira_issue_id
FROM linear.issue AS lissue
INNER JOIN linear.team AS team
	ON lissue.team_id = team.id
INNER JOIN linear.attachment AS att
	ON lissue.id = att.issue_id
	AND att.url IS NOT NULL
INNER JOIN jra.issue AS jissue
	ON att.url = 'https://gpventure.atlassian.net/browse/' || jissue.key