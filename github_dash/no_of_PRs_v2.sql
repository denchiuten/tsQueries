SELECT 
	r.id AS repo_id,
	r.name AS repo_name,
	bcr.branch_name,
	cpr.pull_request_id,
	cpr.commit_sha,
	c.committer_date::DATE,
	pr.created_at::DATE AS pr_create_date,
	e.full_name AS committer_name,
	c.author_name AS github_author_name,
	e.email AS committer_email,
	c.author_email AS github_author_email,
 	et.department AS employee_dept,
	et.team_name AS employee_team
FROM github.commit_pull_request AS cpr -- all commits that are associated with a pull request (prior to squash)
INNER JOIN github.commit AS c -- join to commit table to get commit details
	ON cpr.commit_sha = c.sha
INNER JOIN github.pull_request AS pr
	ON cpr.pull_request_id = pr.id
INNER JOIN google_sheets.github_users AS gu
	ON c.author_email = gu.author_email -- use author email as the committer can sometimes be a bot
INNER JOIN bob.employee AS e
	ON gu.work_email = e.email 
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed' -- filtering for only active employee if committer is a terrascope staff 
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
INNER JOIN github.repository AS r -- to get repository and branch name
	ON pr.base_repo_id = r.id 
INNER JOIN github.branch_commit_relation AS bcr
	ON cpr.commit_sha = bcr.commit_sha
WHERE pr.created_at IS NOT NULL