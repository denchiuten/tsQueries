SELECT DISTINCT
	r.id,
	r.name AS repo_name,
	bcr.branch_name AS branch_name,
	et.team_name,
	e.full_name,
	e.email,
	COUNT(c.sha) AS commit_count,
	DATE_TRUNC('month', c.committer_date) AS commit_date
FROM github.branch_commit_relation AS bcr
INNER JOIN github.commit AS c
	ON bcr.commit_sha = c.sha
INNER JOIN github.repository AS r
	ON c.repository_id = r.id
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
INNER JOIN bob.vw_employee_team AS et
	ON ue.email = et.email
-- JOIN to employee table to filter only active employees within bob --
INNER JOIN bob.employee AS e
	ON et.email = e.email 
	AND e._fivetran_deleted IS FALSE
	AND e.internal_status IS NULL
GROUP BY 1,2,3,4,5,6,8
ORDER BY 2,3,4
	
	