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
INNER JOIN google_sheets.github_users AS gu	
	ON c.author_email = gu.author_email -- use author email as the committer can sometimes be a bot
INNER JOIN bob.employee AS e
	ON gu.work_email = e.email
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed'
INNER JOIN bob.vw_employee_team AS et
	ON e.id = et.employee_id
	AND et.team_id IN ('260856300', -- Applications Engineering
                       '256407635', -- Architecture
                       '261185810', -- CloudOps
                       '256407654', -- Data Science
                       '256407652', -- DevSecOps
                       '256407642', -- Engineering
                       '256407643', -- Implementation
                       '256407644', -- Platform Engineering
                       '256407655') -- Solution Engineering
