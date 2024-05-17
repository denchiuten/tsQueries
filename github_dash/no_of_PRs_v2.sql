SELECT DISTINCT
	r.name AS repository_name,
	bcr.branch_name AS branch_name,
	et.team_name,
	e.full_name,
	e.email,
	COUNT(pr.id) AS PR_count,
	pr.created_at::DATE
	
FROM github.branch_commit_relation AS bcr
INNER JOIN github.commit AS c
	ON bcr.commit_sha = c.sha
	
INNER JOIN github.commit_pull_request AS cpr
	ON c.sha = cpr.commit_sha
		
INNER JOIN github.pull_request AS pr
	ON cpr.pull_request_id = pr.id
	AND cpr.commit_sha = pr.head_sha	
	
INNER JOIN github.repository AS r
	ON c.repository_id = r.id

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

WHERE c.committer_name != 'GitHub'
	AND branch_name != 'main'	
GROUP BY 1,2,3,4,5,7
ORDER BY 1,2,3,4,5,7