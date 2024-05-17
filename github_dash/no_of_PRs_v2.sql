SELECT 
	r.full_name,
	bcr.branch_name,
	c.committer_name,
	c.committer_email,
	COUNT(pr.id)
FROM github.branch_commit_relation AS bcr
INNER JOIN github.commit AS c
	ON bcr.commit_sha = c.sha
INNER JOIN github.commit_pull_request AS cpr
	ON c.sha = cpr.commit_sha	
INNER JOIN github.pull_request AS pr
	ON cpr.pull_request_id = pr.id	
INNER JOIN github.repository AS r
	ON c.repository_id = r.id
WHERE c.committer_email != 'noreply@github.com'	
GROUP BY 1,2,3,4
ORDER BY 1,2,3