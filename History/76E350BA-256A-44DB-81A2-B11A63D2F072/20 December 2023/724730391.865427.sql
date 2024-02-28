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
		ON att.url = 'https://gpventure.atlassian.net/browse/' || j.key
		AND j._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND l._fivetran_deleted IS FALSE