SELECT
	lissue.id AS linear_issue_id,
	lissue.identifier AS linear_issue_key,
	team.name AS team_name,
	team.id AS team_id,
	jissue.key AS jira__issue_key,
	jissue.id AS jira_issue_id,
	p.key AS jira_project_key
FROM linear.issue AS lissue
INNER JOIN linear.team AS team 
	ON lissue.team_id = team.id
INNER JOIN linear.attachment AS att 
	ON lissue.id = att.issue_id
	AND att.url IS NOT NULL
INNER JOIN jra.issue AS jissue 
	ON att.url = 'https://gpventure.atlassian.net/browse/' || jissue.key
INNER JOIN jra.project AS p
	ON jissue.project = p.id
WHERE
	1 = 1
	AND lissue._fivetran_deleted IS FALSE