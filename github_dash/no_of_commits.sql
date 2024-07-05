SELECT DISTINCT
	r.id AS repo_id,
	r.name AS repo_name,
	bcr.branch_name AS branch_name,
	et.department AS employee_dept,
	et.team_name AS employee_team,
	e.id AS employee_id,
	e.full_name AS employee_fullname,
	e.email AS employee_email,
	COUNT(c.sha) AS commit_count,
	c.committer_date AS commit_date
FROM github.commit AS c 
INNER JOIN github.branch_commit_relation AS bcr -- to get repo's branch name
	ON c.sha = bcr.commit_sha
INNER JOIN github.repository AS r
	ON c.repository_id = r.id
INNER JOIN github.user_email AS ue
	ON c.author_email = ue.email -- using author email instead of committer here
INNER JOIN github.user as u
	ON ue.user_id = u.id 
INNER JOIN github.user_with_email AS uwe
	ON u.id = uwe.id -- to get users actual terrascope email for joining to bob 
INNER JOIN bob.employee AS e
	ON uwe.email = e.email 
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed' -- getting only active employees 
INNER JOIN bob.vw_employee_team AS et
	ON e.id = et.employee_id
GROUP BY 1,2,3,4,5,6,7,8,10