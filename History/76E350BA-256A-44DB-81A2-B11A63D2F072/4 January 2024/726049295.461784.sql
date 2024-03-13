SELECT
	u.id,
	u.email
FROM linear.users AS u
WHERE
	1 = 1
	AND u._fivetran_deleted IS FALSE
	AND u.active IS TRUE
ORDER BY 2;