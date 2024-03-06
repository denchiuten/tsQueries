WITH ljmap AS (
	SELECT
		l.id AS linear_id,
		l.identifier AS linear_child_issue_key,
		j.id AS jira_id,
		j.key AS jira_key
	FROM linear.issue AS l
	INNER JOIN linear.attachment AS att 
		ON l.id = att.issue_id
		AND att.url IS NOT NULL
		AND att._fivetran_deleted IS FALSE
	INNER JOIN jra.issue AS j
		ON REPLACE(att.url, 'https://gpventure.atlassian.net/browse/', '') = j.key
		AND j._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND l._fivetran_deleted IS FALSE
)

SELECT
	lchild.id AS linear_child_issue_id,
	lchild.identifier AS linear_child_issue_key,
	team.name AS linear_team_name,
	team.id AS linear_team_id,
	jchild.key AS jira_child_issue_key,
	jchild.id AS jira_child_issue_id,
	jchild.parent_id AS jira_parent_issue_id,
	jparent.key AS jira_parent_issue_key

FROM linear.issue AS lchild
INNER JOIN linear.team AS team
	ON lchild.team_id = team.id
	AND team._fivetran_deleted IS FALSE
INNER JOIN linear.attachment AS att 
	ON lchild.id = att.issue_id
	AND att.url IS NOT NULL
	AND att._fivetran_deleted IS FALSE
INNER JOIN jra.issue AS jchild
	ON att.url = 'https://gpventure.atlassian.net/browse/' || jchild.key
	AND jchild._fivetran_deleted IS FALSE
INNER JOIN jra.issue AS jparent
	ON jchild.parent_id = jparent.id
	AND jparent._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND lchild._fivetran_deleted IS FALSE