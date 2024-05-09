SELECT 
	DATE_TRUNC('month', c.committer_date)::DATE AS commit_date,
	et.team_name AS team_name,
	e.full_name,
	e.email,
	COUNT(c.sha) AS number_of_commits
	 
FROM github.commit AS c

-- JOIN to user table through user_email and filter out bots --
INNER JOIN github.user_email AS ue
	ON c.committer_email = ue.email
INNER JOIN github.user AS u
	ON ue.user_id = u.id
	AND u.type != 'Bot'

-- JOIN to team table through team_membership table to filter for only active users within Terrascope --
INNER JOIN github.team_membership AS tm
	ON u.id = tm.user_id
INNER JOIN github.team AS t
	ON tm.team_id = t.id 
	AND t.org_id = '84950537'
	
-- JOIN to employee team view to identify teams --
LEFT JOIN bob.vw_employee_team AS et
	ON ue.email = et.email
	
-- JOIN to employee table to filter only active employees within bob --
LEFT JOIN bob.employee AS e
	ON et.email = e.email 
	AND e._fivetran_deleted IS FALSE
	AND e.internal_status IS NULL
GROUP BY 1,2,3,4
ORDER BY 2,3