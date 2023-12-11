CREATE VIEW harvest.vw_users_latest AS 
SELECT
	u.*
FROM harvest.users AS u
INNER JOIN (
	SELECT
		id,
		MAX(updated_at) AS updated_at
	FROM harvest.users
	GROUP BY 1
) AS latest
	ON u.id = latest.id
	AND u.updated_at = latest.updated_at;