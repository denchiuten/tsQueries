SELECT
	r.id AS repo_id,
	r.name AS repo_name,
	bcr.branch_name AS branch_name,
	c.sha AS commit_id,
	c.committer_date::DATE AS commit_date,
	COALESCE(e.full_name, c.author_name) AS committer_name, 
	COALESCE(e.email, c.author_email) AS committer_email,
	et.department AS employee_dept,
	et.team_name AS employee_team
FROM github.commit AS c 
INNER JOIN github.branch_commit_relation AS bcr -- to get repo's branch name
	ON c.sha = bcr.commit_sha
INNER JOIN github.repository AS r
	ON c.repository_id = r.id
LEFT JOIN github.user_email AS ue
	ON c.author_email = ue.email -- use author email as the committer can sometimes be a bot
LEFT JOIN github.user as u
	ON ue.user_id = u.id 
LEFT JOIN github.user_with_email AS uwe
	ON u.id = uwe.id -- to get users actual terrascope email for joining to bob 
LEFT JOIN bob.employee AS e
	ON uwe.email = e.email 
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed' -- getting only active employees 
LEFT JOIN bob.vw_employee_team AS et
	ON e.id = et.employee_id
	AND et.department = 'Technology'