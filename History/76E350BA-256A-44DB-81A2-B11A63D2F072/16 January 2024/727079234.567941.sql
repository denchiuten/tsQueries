SELECT *
FROM plumbing.vw_tool_users AS u
WHERE
	1 = 1
	AND u.tool <> 'auth0'
	AND u.bob_status <> 'Active'