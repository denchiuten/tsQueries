SELECT 
	r.id AS repo_id,
	r.name AS repo_name,
	bcr.branch_name,
	cpr.pull_request_id,
	cpr.commit_sha,
	c.committer_date,
	pr.created_at AS pr_create_date,
	CASE WHEN u.id = uwe.id THEN e.full_name ELSE c.committer_name END AS committer_name,
	CASE WHEN u.id = uwe.id THEN e.email ELSE c.committer_email END AS committer_email,
	et.department AS employee_dept,
	et.team_name AS employee_team
FROM github.commit_pull_request AS cpr -- all commits that are associated with a pull request (prior to squash)
INNER JOIN github.commit AS c -- join to commit table to get commit details
	ON cpr.commit_sha = c.sha
LEFT JOIN github.pull_request AS pr
	ON cpr.pull_request_id = pr.id
		
LEFT JOIN github.user_email AS ue
	ON c.author_email = ue.email -- using author email instead of committer here
LEFT JOIN github.user as u
	ON ue.user_id = u.id 
	AND u.type <> 'Bot' -- filter out bot users if any 
LEFT JOIN github.user_with_email AS uwe -- LEFT JOIN as not all committer has a terrascope email (external staffs)
	ON u.id = uwe.id 
	
LEFT JOIN bob.employee AS e
	ON uwe.email = e.email 
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed' -- filtering for only active employee if committer is a terrascope staff 
LEFT JOIN bob.vw_employee_team AS et
	ON e.id = et.employee_id
	
LEFT JOIN github.repository AS r
	ON pr.base_repo_id = r.id 
INNER JOIN github.branch_commit_relation AS bcr
	ON cpr.commit_sha = bcr.commit_sha

WHERE pr.created_at IS NOT NULL