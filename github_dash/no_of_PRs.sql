SELECT 
 	pr.created_at,
 	et.team_name AS team_name,
	e.full_name,
	e.email,
	COUNT(pr.head_user_id) AS number_of_PRs

FROM github.pull_request AS pr

-- JOIN to user table through user_email and filter out bots --
INNER JOIN github.user_email AS ue
	ON pr.head_user_id = ue.user_id
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
	

	
	
-- checking the different types of users submitting pull request -- 
SELECT DISTINCT 
	pr.head_user_id, 
	u.name 
FROM github.pull_request AS pr 
INNER JOIN github.user AS u 
	ON pr.head_user_id = u.id