WITH ljmap AS (
	SELECT
		l.id AS linear_child_issue_id,
		l.identifier AS linear_child_issue_key,
		j.id AS jira_child_issue_id,
		j.key AS jira_child_issue_key,
		j.parent_id AS jira_parent_issue_id
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
	child.*,
	parent.linear_child_issue_id AS linear_parent_issue_id,
	parent.jira_child_issue_key AS jira_parent_issue_id,
	t.name AS issue_type
FROM ljmap AS child
LEFT JOIN jra.issue AS i
	ON child.jira_parent_issue_id = i.id
	AND i._fivetran_deleted IS FALSE
LEFT JOIN jra.issue_type AS t
	ON i.issue_type = t.id
LEFT JOIN ljmap AS parent
	ON child.jira_parent_issue_id = parent.jira_child_issue_id