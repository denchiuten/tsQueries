SELECT
	u.name,
	tm.team_id
FROM linear.users AS u
INNER JOIN linear.team_member AS tm
	ON u.id = tm.member_id
ORDER BY 1,2