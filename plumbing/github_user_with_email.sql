CREATE OR REPLACE VIEW github.user_with_email AS (
	SELECT
		vu.email,
		u.*
	FROM github.user AS u
	INNER JOIN vanta.github_users AS vg
		ON u.login = vg.account_name
		AND vg.is_deactivated IS FALSE
	LEFT JOIN vanta.users AS vu
		ON vg.vanta_id = vu.id
	WHERE
		u.type = 'User'
)