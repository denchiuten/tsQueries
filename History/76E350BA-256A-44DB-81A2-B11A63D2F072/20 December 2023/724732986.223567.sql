SELECT
	l.id AS linear_issue_id,
	l.identifier AS linear_issue_key,
	j.id AS jira_issue_id,
	j.key AS jira_issue_key,
	j.parent_id AS jira_parent_issue_id,
	p.key AS jira_parent_issue_key,
	type.name AS jira_parent_issue_type
FROM linear.issue AS l
INNER JOIN linear.attachment AS att 
	ON l.id = att.issue_id
	AND att.url IS NOT NULL
	AND att._fivetran_deleted IS FALSE
INNER JOIN jra.issue AS j
	ON REPLACE(att.url, 'https://gpventure.atlassian.net/browse/', '') = j.key
	AND j._fivetran_deleted IS FALSE
LEFT JOIN jra.issue AS p
	ON j.parent_id = p.id
	AND p._fivetran_deleted IS FALSE
LEFT JOIN jra.issue_type AS type
	ON p.issue_type = type.id
	AND type._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND l._fivetran_deleted IS FALSE