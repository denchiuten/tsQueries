SELECT
	lchild.id AS linear_issue_id,
	lchild.identifier AS linear_issue_key,
	team.name AS team_name,
	team.id AS team_id,
	jchild.key AS jira__issue_key,
	jchild.id AS jira_issue_id,
	p.key AS jira_project_key
FROM linear.issue AS lchild
INNER JOIN linear.team AS team
	ON lchild.team_id = team.id
INNER JOIN linear.attachment AS att 
	ON lchild.id = att.issue_id
	AND att.url IS NOT NULL
INNER JOIN jra.issue AS jchild
	ON att.url = 'https://gpventure.atlassian.net/browse/' || jchild.key
INNER JOIN jra.project AS p
	ON jissue.project = p.id