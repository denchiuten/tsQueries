SELECT DISTINCT
	u.id AS user_id,
	u.login,
	em.email AS ts_email
FROM github.user AS u
-- link users to a team
INNER JOIN github.team_membership AS tm
	ON u.id = tm.user_id
-- pull the team info
INNER JOIN github.team AS t
	ON tm.team_id = t.id
	AND t.org_id = 84950537 -- org_id for Terrascope Github organisation

-- find the terrascope email address associated with each account (if any)
LEFT JOIN github.user_email AS em
	ON u.id = em.user_id
	AND em.email LIKE '%@terrascope.com'
ORDER BY LOWER(u.login)