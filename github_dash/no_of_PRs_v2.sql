SELECT
	r.name AS repository_name,
	bcr.branch_name AS branch_name,
	e.department,
	clv.name AS team_name,
	e.id AS employee_id,
	e.full_name,
	e.email,
	COUNT(DISTINCT pr.id) AS pr_count,
	DATE_TRUNC('month', pr.created_at) AS pr_date

FROM github.pull_request AS pr 
INNER JOIN github.repository AS r
	ON pr.base_repo_id = r.id
INNER JOIN github.commit_pull_request AS cpr -- for commit pull relations
	ON pr.id = cpr.pull_request_id
INNER JOIN github.branch_commit_relation AS bcr -- to get repo branch names
	ON cpr.commit_sha = bcr.commit_sha
INNER JOIN github.commit AS c -- to get individual commiters
	ON cpr.commit_sha = c.sha

INNER JOIN github.user_email AS ue
	ON c.author_email = ue.email -- using author email instead of committer here
INNER JOIN github.user as u
	ON ue.user_id = u.id 
	AND u.type != 'Bot' -- filter out bot users if any 
INNER JOIN github.user_with_email AS uwe
	ON u.id = uwe.id -- to get users actual terrascope email for joining to bob 
INNER JOIN bob.employee AS e
	ON uwe.email = e.email 
	AND e._fivetran_deleted IS FALSE 
	AND e.lifecycle_status = 'Employed' -- getting only active employees 
INNER JOIN bob.employee_work_history AS eh
	ON e.id = eh.employee_id -- join for filtering on bob company table later on
INNER JOIN bob.company AS clv
	ON JSON_EXTRACT_PATH_TEXT(eh.custom_columns, 'column_1681191721226') = clv.id

WHERE JSON_EXTRACT_PATH_TEXT(eh.custom_columns, 'column_1681191721226') <> ''
	AND eh.is_current IS TRUE 

GROUP BY 1,2,3,4,5,6,7,9

